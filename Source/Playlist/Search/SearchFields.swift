//
//  SearchFields.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  

///
/// Enumerates the track fields used as playlist search criteria.
///
struct SearchFields: OptionSet {
    
    let rawValue: Int
    
    static let name = SearchFields(rawValue: 1 << 0)
    static let artist = SearchFields(rawValue: 1 << 1)
    static let title = SearchFields(rawValue: 1 << 2)
    static let album = SearchFields(rawValue: 1 << 3)
    
    static let none: SearchFields = []
    static let all: SearchFields = [name, artist, title, album]
}
