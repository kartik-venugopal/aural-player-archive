//
//  HistoryDelegateProtocol.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// A functional contract for a delegate allowing access to the chronologically ordered track lists:
/// 1. tracks recently added to the playlist
/// 2. tracks recently played
///
/// Acts as a middleman between the UI and the History lists,
/// providing a simplified interface / facade for the UI layer to manipulate the History lists
/// and add / play tracks from those lists.
///
/// - SeeAlso: `AddedItem`
/// - SeeAlso: `PlayedItem`
///
protocol HistoryDelegateProtocol {
    
    // Retrieves all items from the Recently added list, in chronological order
    func allRecentlyAddedItems() -> [AddedItem]
    
    // Retrieves all recently played items
    func allRecentlyPlayedItems() -> [PlayedItem]
    
    // Adds a given item (file/folder) to the playlist
    func addItem(_ item: URL) throws
    
    // Plays a given item track.
    func playItem(_ item: URL, fromPosition startPosition: Double?) throws
    
    func resizeLists(_ recentlyAddedListSize: Int, _ recentlyPlayedListSize: Int)
    
    func clearAllHistory()
    
    func deleteItem(_ item: PlayedItem)

    func deleteItem(_ item: AddedItem)
    
    func markLastPlaybackPosition(_ position: Double)
    
    var lastPlaybackPosition: Double {get}
    
    var lastPlayedItem: PlayedItem? {get}
    
    func resumeLastPlayedTrack() throws
}

extension HistoryDelegateProtocol {
    
    func playItem(_ item: URL) throws {
        try playItem(item, fromPosition: nil)
    }
}
