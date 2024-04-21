//
//  FileReaderProtocol.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// A functional contract for a class that handles loading of metadata for a file.
///
/// NOTE - Since this class accepts files as input (as opposed to **Track** objects), it can be used to load
/// metadata for files that are not present in the playlist as tracks. (e.g. files in the history or favorites menu)
///
protocol FileReaderProtocol {
    
    ///
    /// Loads the essential metadata fields that are required for a track to be loaded into the playlist upon app startup.
    ///
    func getPlaylistMetadata(for file: URL) throws -> PlaylistMetadata
    
    func computeAccurateDuration(for file: URL) -> Double?
    
    ///
    /// Loads all metadata and resources that are required for track playback.
    ///
    func getPlaybackMetadata(for file: URL) throws -> PlaybackContextProtocol
    
    ///
    /// Loads cover art for a file.
    ///
    func getArt(for file: URL) -> CoverArt?
    
    ///
    /// Loads all non-essential ("auxiliary") metadata associated with a track, for display in the "Detailed track info" view.
    ///
    func getAuxiliaryMetadata(for file: URL, loadingAudioInfoFrom playbackContext: PlaybackContextProtocol?) -> AuxiliaryMetadata
    
    func getAllMetadata(for file: URL) -> FileMetadata
}
