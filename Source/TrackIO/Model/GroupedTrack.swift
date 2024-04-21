//
//  GroupedTrack.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  

///
/// Wrapper around **Track** that includes its location within a group in a hierarchical playlist.
///
struct GroupedTrack {
    
    let track: Track
    let group: Group
    
    let trackIndex: Int
    let groupIndex: Int
}
