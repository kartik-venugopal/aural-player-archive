//
//  GenresPlaylistViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    View controller for the "Genres" playlist view
 */
class GenresPlaylistViewController: GroupingPlaylistViewController {
    
    override var groupType: GroupType {.genre}
    override var playlistType: PlaylistType {.genres}

    override var nibName: String? {"Genres"}
}
