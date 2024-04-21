//
//  MusicBrainzArtistCredit.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// Represents an "artist credit" entity in the **MusicBrainz** domain model.
/// An artist credit references an artist who has been credited for a particular release.
///
class MusicBrainzArtistCredit {

    ///
    /// The name of the artist of this credit.
    ///
    /// NOTE - This may or may not match the 'artist.name' field.
    ///
    var name: String
    
    ///
    /// The artist of this credit.
    ///
    var artist: MusicBrainzArtist

    ///
    /// Conditionally initializes this object, given a dictionary containing key-value pairs corresponding to members of this object.
    ///
    /// NOTE - Returns nil if the input dictionary does not contain all the fields required for this object.
    ///
    init?(_ dict: NSDictionary) {

        // Validate the dictionary (all fields must be present).
        guard let name = dict["name", String.self],
              let artist = dict["artist", NSDictionary.self],
              let mbArtist = MusicBrainzArtist(artist) else {return nil}

        self.name = name
        self.artist = mbArtist
    }
}
