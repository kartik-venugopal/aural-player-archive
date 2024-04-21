//
//  PlaylistPreferences.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

///
/// Encapsulates all user preferences pertaining to the playlist.
///
class PlaylistPreferences: PersistentPreferencesProtocol {
    
    var playlistOnStartup: PlaylistStartupOptions
    
    // This will be used only when playlistOnStartup == PlaylistStartupOptions.loadFile
    var playlistFile: URL?
    
    // This will be used only when playlistOnStartup == PlaylistStartupOptions.loadFolder
    var tracksFolder: URL?
    
    var viewOnStartup: PlaylistViewOnStartup
    
    var showNewTrackInPlaylist: Bool
    var showChaptersList: Bool
    
    var dragDropAddMode: PlaylistTracksAddMode
    var openWithAddMode: PlaylistTracksAddMode
    
    // ------ MARK: Property keys ---------
    
    private static let keyPrefix: String = "playlist"
    
    static let key_viewOnStartupOption: String = "\(keyPrefix).viewOnStartup.option"
    static let key_viewOnStartupViewName: String = "\(keyPrefix).viewOnStartup.view"
    
    static let key_playlistOnStartup: String = "\(keyPrefix).playlistOnStartup"
    static let key_playlistFile: String = "\(keyPrefix).playlistOnStartup.playlistFile"
    static let key_tracksFolder: String = "\(keyPrefix).playlistOnStartup.tracksFolder"
    
    static let key_showNewTrackInPlaylist: String = "\(keyPrefix).showNewTrackInPlaylist"
    static let key_showChaptersList: String = "\(keyPrefix).showChaptersList"
    
    static let key_dragDropAddMode: String = "\(keyPrefix).dragDropAddMode"
    static let key_openWithAddMode: String = "\(keyPrefix).openWithAddMode"
    
    private typealias Defaults = PreferencesDefaults.Playlist
    
    internal required init(_ dict: [String: Any]) {
        
        viewOnStartup = Defaults.viewOnStartup
        
        if let viewOnStartupOption = dict.enumValue(forKey: Self.key_viewOnStartupOption, ofType: PlaylistViewStartupOptions.self) {
            viewOnStartup.option = viewOnStartupOption
        }
        
        if let viewName = dict[Self.key_viewOnStartupViewName, String.self] {
            viewOnStartup.viewName = viewName
        }
        
        playlistOnStartup = dict.enumValue(forKey: Self.key_playlistOnStartup, ofType: PlaylistStartupOptions.self) ?? Defaults.playlistOnStartup
        
        playlistFile = dict.urlValue(forKey: Self.key_playlistFile) ?? Defaults.playlistFile
        
        showNewTrackInPlaylist = dict[Self.key_showNewTrackInPlaylist, Bool.self] ?? Defaults.showNewTrackInPlaylist
        
        showChaptersList = dict[Self.key_showChaptersList, Bool.self] ?? Defaults.showChaptersList
        
        // If .loadFile selected but no file available to load from, revert back to dict
        if playlistOnStartup == .loadFile && playlistFile == nil {
            
            playlistOnStartup = Defaults.playlistOnStartup
            playlistFile = Defaults.playlistFile
        }
        
        tracksFolder = dict.urlValue(forKey: Self.key_tracksFolder) ?? Defaults.tracksFolder
        
        // If .loadFolder selected but no folder available to load from, revert back to dict
        if playlistOnStartup == .loadFolder && tracksFolder == nil {
            
            playlistOnStartup = Defaults.playlistOnStartup
            tracksFolder = Defaults.tracksFolder
        }
        
        dragDropAddMode = dict.enumValue(forKey: Self.key_dragDropAddMode, ofType: PlaylistTracksAddMode.self) ?? Defaults.dragDropAddMode
        openWithAddMode = dict.enumValue(forKey: Self.key_openWithAddMode, ofType: PlaylistTracksAddMode.self) ?? Defaults.openWithAddMode
    }
    
    func persist(to defaults: UserDefaults) {
        
        defaults[Self.key_playlistOnStartup] = playlistOnStartup.rawValue 
        defaults[Self.key_playlistFile] = playlistFile?.path 
        defaults[Self.key_tracksFolder] = tracksFolder?.path 
        
        defaults[Self.key_viewOnStartupOption] = viewOnStartup.option.rawValue 
        defaults[Self.key_viewOnStartupViewName] = viewOnStartup.viewName 
        
        defaults[Self.key_showNewTrackInPlaylist] = showNewTrackInPlaylist 
        defaults[Self.key_showChaptersList] = showChaptersList
        
        defaults[Self.key_dragDropAddMode] = dragDropAddMode.rawValue
        defaults[Self.key_openWithAddMode] = openWithAddMode.rawValue
    }
}

// All options for the playlist at startup
enum PlaylistStartupOptions: String, CaseIterable {
    
    case empty
    case rememberFromLastAppLaunch
    case loadFile
    case loadFolder
}

// Playlist view on startup preference
class PlaylistViewOnStartup {
    
    var option: PlaylistViewStartupOptions = .rememberFromLastAppLaunch
    
    // This is used only if option == .specific
    var viewName: String = "Tracks"
    
    var viewIndex: Int {
        
        switch viewName {
            
        case "Artists":  return 1;
            
        case "Albums":  return 2;
            
        case "Genres": return 3;
            
        default:    return 0;
            
        }
    }
    
    // NOTE: This is mutable. Potentially unsafe
    static let defaultInstance: PlaylistViewOnStartup = PlaylistViewOnStartup()
}

enum PlaylistTracksAddMode: String, CaseIterable {
    
    case append
    case replace
    case hybrid
}

enum PlaylistViewStartupOptions: String, CaseIterable {
    
    case specific
    case rememberFromLastAppLaunch
}
