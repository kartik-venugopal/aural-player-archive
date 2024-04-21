//
//  BookmarksMenuController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    Manages and provides actions for the Bookmarks menu that displays bookmarks that can be opened by the player.
 */
class BookmarksMenuController: NSObject, NSMenuDelegate {
    
    private var bookmarks: BookmarksDelegateProtocol = objectGraph.bookmarksDelegate
    
    // Delegate used to perform playback
    private let player: PlaybackDelegateProtocol = objectGraph.playbackDelegate
    
    @IBOutlet weak var bookmarkTrackPositionMenuItem: NSMenuItem!
    @IBOutlet weak var bookmarkTrackSegmentLoopMenuItem: NSMenuItem!
    @IBOutlet weak var manageBookmarksMenuItem: NSMenuItem!
    
    private lazy var managerWindowController: PresetsManagerWindowController = PresetsManagerWindowController.instance
    
    private lazy var playlist: PlaylistDelegateProtocol = objectGraph.playlistDelegate
    private lazy var fileReader: FileReader = objectGraph.fileReader
    
    private lazy var messenger = Messenger(for: self)
    
    private lazy var windowLayoutsManager: WindowLayoutsManager = objectGraph.windowLayoutsManager
    
    fileprivate lazy var artLoadingQueue: OperationQueue = OperationQueue(opCount: max(System.numberOfActiveCores / 2, 2),
                                                                          qos: .userInteractive)
    
    // Before the menu opens, re-create the menu items from the model
    func menuNeedsUpdate(_ menu: NSMenu) {
        
        // Can't add a bookmark if no track is playing or if the popover is currently being shown
        let playingOrPaused = player.state.isPlayingOrPaused
        
        bookmarkTrackPositionMenuItem.enableIf(playingOrPaused && !windowLayoutsManager.isShowingModalComponent)

        let hasCompleteLoop = player.playbackLoop?.isComplete ?? false
        bookmarkTrackSegmentLoopMenuItem.enableIf(playingOrPaused && hasCompleteLoop)

        manageBookmarksMenuItem.enableIf(bookmarks.count > 0)
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        
        // Remove existing (possibly stale) items, starting after the static items
        while menu.items.count > 4 {
            menu.removeItem(at: 4)
        }
        
        // Recreate the bookmarks menu (reverse so that newer items appear first).
        bookmarks.allBookmarks.reversed().forEach {menu.addItem(createBookmarkMenuItem($0))}
    }
    
    func menuDidClose(_ menu: NSMenu) {
        artLoadingQueue.cancelAllOperations()
    }
    
    // Factory method to create a single history menu item, given a model object (HistoryItem)
    private func createBookmarkMenuItem(_ bookmark: Bookmark) -> NSMenuItem {
        
        // The action for the menu item will depend on whether it is a playable item
        let action = #selector(self.playSelectedItemAction(_:))
        
        let menuItem = BookmarksMenuItem(title: "  " + bookmark.name, action: action)
        menuItem.target = self
        
        menuItem.image = Images.imgPlayedTrack
        menuItem.image?.size = menuItemCoverArtImageSize
        
        artLoadingQueue.addOperation {[weak self] in
            
            if let theImage = self?.playlist.findFile(bookmark.file)?.art?.image ?? self?.fileReader.getArt(for: bookmark.file)?.image,
               let imgCopy = theImage.copy() as? NSImage {
                
                imgCopy.size = menuItemCoverArtImageSize
                
                DispatchQueue.main.async {
                    menuItem.image = imgCopy
                }
            }
        }
        
        menuItem.bookmark = bookmark
        
        return menuItem
    }
    
    // When a bookmark menu item is clicked, the item is played
    @IBAction func bookmarkTrackPositionAction(_ sender: Any) {
        messenger.publish(.player_bookmarkPosition)
    }
    
    // When a bookmark menu item is clicked, the item is played
    @IBAction func bookmarkTrackSegmentLoopAction(_ sender: Any) {
        messenger.publish(.player_bookmarkLoop)
    }
    
    // When a bookmark menu item is clicked, the item is played
    @IBAction fileprivate func playSelectedItemAction(_ sender: BookmarksMenuItem) {
        
        do {
            
            if let bookmark = sender.bookmark {
                try bookmarks.playBookmark(bookmark)
            }
            
        } catch {
            
            if let fnfError = error as? FileNotFoundError {
                
                // TODO: When this error occurs, offer more options like "Point to the new location of the file".
                
                // This needs to be done async. Otherwise, other open dialogs could hang.
                DispatchQueue.main.async {
                    
                    // Position and display an alert with error info
                    _ = DialogsAndAlerts.trackNotPlayedAlertWithError(fnfError, "Remove bookmark").showModal()
                    self.bookmarks.deleteBookmarkWithName(sender.bookmark.name)
                }
            }
        }
    }
    
    @IBAction func manageBookmarksAction(_ sender: Any) {
        managerWindowController.showBookmarksManager()
    }
}

// Helper class that stores a Bookmark for convenience (when playing it)
class BookmarksMenuItem: NSMenuItem {
    
    var bookmark: Bookmark!
}
