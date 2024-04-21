//
//  CloseFileHandlesAction.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// Chain of responsibility action that closes all open audio file handles for tracks that
/// have previously been prepared for playback. There should not be any audio file
/// handles open when no track is being played (i.e. when playback is stopped).
///
class CloseFileHandlesAction: PlaybackChainAction {
    
    private let playlist: PlaylistAccessorProtocol
    
    init(playlist: PlaylistAccessorProtocol) {
        self.playlist = playlist
    }
    
    func execute(_ context: PlaybackRequestContext, _ chain: PlaybackChain) {
        
        // Iterate through all tracks in the playlist,
        // and close their associated playback contexts
        // i.e. audio file handles.
        for track in playlist.tracks {
            track.playbackContext?.close()
        }
        
        chain.proceed(context)
    }
}
