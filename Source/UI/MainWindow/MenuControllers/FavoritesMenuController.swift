//
//  FavoritesMenuController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

class FavoritesMenuController: NSObject, NSMenuDelegate {
    
    // Menu that displays tracks marked "favorites". Clicking on any of these items will result in the track being  played.
    @IBOutlet weak var favoritesMenu: NSMenu!
    
    @IBOutlet weak var addRemoveFavoritesMenuItem: ToggleMenuItem!
    @IBOutlet weak var manageFavoritesMenuItem: NSMenuItem!    

    // Delegate that performs CRUD on the favorites model
    private let favorites: FavoritesDelegateProtocol = objectGraph.favoritesDelegate
    
    private lazy var playbackInfo: PlaybackInfoDelegateProtocol = objectGraph.playbackInfoDelegate
    
    private lazy var playlist: PlaylistDelegateProtocol = objectGraph.playlistDelegate
    
    private lazy var managerWindowController: PresetsManagerWindowController = PresetsManagerWindowController.instance
    
    private lazy var fileReader: FileReader = objectGraph.fileReader
    
    private lazy var messenger = Messenger(for: self)
    
    fileprivate lazy var artLoadingQueue: OperationQueue = OperationQueue(opCount: max(System.numberOfActiveCores / 2, 2),
                                                                          qos: .userInteractive)
    
    // One-time setup, when the menu loads
    override func awakeFromNib() {
        addRemoveFavoritesMenuItem.off()
    }
    
    // Before the menu opens, re-create the menu items from the model
    func menuNeedsUpdate(_ menu: NSMenu) {
        
        // These menu item actions are only available when a track is currently playing/paused
        addRemoveFavoritesMenuItem.enableIf(playbackInfo.state.isPlayingOrPaused)
        
        // Menu has 3 static items
        manageFavoritesMenuItem.enableIf(favorites.count > 0)
    }

    func menuWillOpen(_ menu: NSMenu) {
        
        if let playingTrackFile = playbackInfo.playingTrack?.file {
            addRemoveFavoritesMenuItem.onIf(favorites.favoriteWithFileExists(playingTrackFile))
        } else {
            addRemoveFavoritesMenuItem.off()
        }
        
        // Remove existing (possibly stale) items, starting after the static items
        while favoritesMenu.items.count > 3 {
            favoritesMenu.removeItem(at: 3)
        }
        
        // Recreate the menu (reverse so that newer items appear first).
        favorites.allFavorites.reversed().forEach {favoritesMenu.addItem(createFavoritesMenuItem($0))}
    }
    
    func menuDidClose(_ menu: NSMenu) {
        artLoadingQueue.cancelAllOperations()
    }
    
    // Factory method to create a single Favorites menu item, given a model object (FavoritesItem)
    private func createFavoritesMenuItem(_ item: Favorite) -> NSMenuItem {
        
        // The action for the menu item will depend on whether it is a playable item
        let action = #selector(self.playSelectedItemAction(_:))
        
        let menuItem = FavoritesMenuItem(title: "  " + item.name, action: action)
        menuItem.target = self
        
        menuItem.image = Images.imgPlayedTrack
        menuItem.image?.size = menuItemCoverArtImageSize
        
        artLoadingQueue.addOperation {[weak self] in
            
            if let theImage = self?.playlist.findFile(item.file)?.art?.image ?? self?.fileReader.getArt(for: item.file)?.image,
               let imgCopy = theImage.copy() as? NSImage {
                
                imgCopy.size = menuItemCoverArtImageSize
                
                DispatchQueue.main.async {
                    menuItem.image = imgCopy
                }
            }
        }
        
        menuItem.favorite = item
        
        return menuItem
    }
    
    // Adds/removes the currently playing track, if there is one, to/from the "Favorites" list
    @IBAction func favoritesAction(_ sender: Any) {
        messenger.publish(.favoritesList_addOrRemove)
    }
    
    // When a "Favorites" menu item is clicked, the item is played
    @IBAction fileprivate func playSelectedItemAction(_ sender: FavoritesMenuItem) {
        
        let fav = sender.favorite!
        
        do {
            
            try favorites.playFavorite(fav)
            
        } catch {
            
            if let fnfError = error as? FileNotFoundError {
                
                // This needs to be done async. Otherwise, other open dialogs could hang.
                DispatchQueue.main.async {
                    
                    // Position and display an alert with error info
                    _ = DialogsAndAlerts.trackNotPlayedAlertWithError(fnfError, "Remove favorite").showModal()
                    self.favorites.deleteFavoriteWithFile(fav.file)
                }
            }
        }
    }
    
    // Opens the presets manager to manage favorites
    @IBAction func manageFavoritesAction(_ sender: Any) {
        managerWindowController.showFavoritesManager()
    }
}

class FavoritesMenuItem: NSMenuItem {
    
    var favorite: Favorite!
}
