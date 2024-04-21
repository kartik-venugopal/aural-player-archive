//
//  MetadataTrackInfoViewDelegate.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

class MetadataTrackInfoViewDelegate: TrackInfoViewDelegate {
    
    override func infoForTrack(_ track: Track) -> [KeyValuePair] {
        
        var trackInfo: [KeyValuePair] = []
        
        trackInfo.append(KeyValuePair(key: "Title", value: track.title ?? value_unknown))
        trackInfo.append(KeyValuePair(key: "Artist", value: track.artist ?? value_unknown))
        trackInfo.append(KeyValuePair(key: "Album", value: track.album ?? value_unknown))
        trackInfo.append(KeyValuePair(key: "Genre", value: track.genre ?? value_unknown))

        if let trackNum = track.trackNumber {

            if let totalTracks = track.totalTracks, totalTracks > 0 {
                
                trackInfo.append(KeyValuePair(key: "Track#",
                                              value: String(format: "%d / %d", trackNum, totalTracks)))
            } else if trackNum > 0 {
                
                trackInfo.append(KeyValuePair(key: "Track#",
                                              value: String(trackNum)))
            }
        }

        if let discNum = track.discNumber {

            if let totalDiscs = track.totalDiscs, totalDiscs > 0 {
                
                trackInfo.append(KeyValuePair(key: "Disc#",
                                              value: String(format: "%d / %d", discNum, totalDiscs)))
                
            } else if discNum > 0 {
                
                trackInfo.append(KeyValuePair(key: "Disc#",
                                              value: String(discNum)))
            }
        }

        // TODO: Sort the metadata so that junk comes last (e.g. iTunesNORM and UPC's, etc)

        var sortedArr = [(key: String, entry: MetadataEntry)]()

        for (_, entry) in track.auxiliaryMetadata {
            sortedArr.append((key: entry.key, entry: entry))
        }

        sortedArr.sort(by: {e1, e2 -> Bool in

            let t1 = e1.entry.format
            let t2 = e2.entry.format

            // If both entries are of the same metadata type (e.g. both are iTunes), compare their formatted keys (ascending order)
            if t1 == t2 {
                return e1.entry.key < e2.entry.key
            }

            // Entries have different metadata types, compare by their sort order
            return t1.sortOrder < t2.sortOrder
        })

        for (_, entry) in sortedArr {

            let fKey = entry.key.trim()

            if !fKey.isEmpty {
                trackInfo.append(KeyValuePair(key: fKey, value: entry.value.trim()))
            }
        }
        
        return trackInfo
    }
}
