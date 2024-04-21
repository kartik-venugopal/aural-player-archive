//
//  FavoritesManagerViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

class FavoritesManagerViewController: PresetsManagerViewController {
    
    // Delegate that relays accessor operations to the bookmarks model
    private let favorites: FavoritesDelegateProtocol = objectGraph.favoritesDelegate
    
    override var nibName: String? {"FavoritesManager"}
    
    override var numberOfPresets: Int {favorites.count}
    
    override func nameOfPreset(atIndex index: Int) -> String {favorites.getFavoriteAtIndex(index).name}
    
    override func deletePresets(atIndices indices: IndexSet) {
        favorites.deleteFavorites(atIndices: tableView.selectedRowIndexes)
    }
    
    override func applyPreset(atIndex index: Int) {
        
        let fav = favorites.getFavoriteAtIndex(index)
        
        do {
            
            try favorites.playFavorite(fav)
            
        } catch {
            
            if let fnfError = error as? FileNotFoundError {
                
                // This needs to be done async. Otherwise, other open dialogs could hang.
                DispatchQueue.main.async {
                    
                    // Position and display an alert with error info
                    _ = DialogsAndAlerts.trackNotPlayedAlertWithError(fnfError, "Remove favorite").showModal()
                    self.favorites.deleteFavoriteWithFile(fav.file)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: View delegate functions
    
    // Returns a view for a single column
    override func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let column = tableColumn else {return nil}
        
        let colID = column.identifier
        let favorite = favorites.getFavoriteAtIndex(row)
        
        return createTextCell(tableView, column, row, colID == .cid_favoriteNameColumn ? favorite.name : favorite.file.path, false)
    }
}

extension NSUserInterfaceItemIdentifier {
    
    // Table view column identifiers
    static let cid_favoriteNameColumn: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("cid_FavoriteName")
}
