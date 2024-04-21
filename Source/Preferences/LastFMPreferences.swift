//
//  LastFMPreferences.swift
//  Aural
//
//  Copyright © 2021 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  

import Foundation

class LastFMPreferences: PersistentPreferencesProtocol {
    
    var sessionKey: String?
    var hasSessionKey: Bool {
        sessionKey != nil
    }
    
    var enableScrobbling: Bool
    var enableLoveUnlove: Bool
    
    private static let keyPrefix: String = "metadata.lastFM"
    
    static let key_sessionKey: String = "\(keyPrefix).sessionKey"
    
    static let key_enableScrobbling: String = "\(keyPrefix).enableScrobbling"
    static let key_enableLoveUnlove: String = "\(keyPrefix).enableLoveUnlove"
    
    private typealias Defaults = PreferencesDefaults.Metadata.LastFM
    
    required init(_ dict: [String : Any]) {
        
        sessionKey = dict[Self.key_sessionKey, String.self]
        
        enableScrobbling = dict[Self.key_enableScrobbling, Bool.self] ?? Defaults.enableScrobbling
        enableLoveUnlove = dict[Self.key_enableLoveUnlove, Bool.self] ?? Defaults.enableLoveUnlove
    }
    
    func persist(to defaults: UserDefaults) {
        
        defaults[Self.key_sessionKey] = sessionKey
        
        defaults[Self.key_enableScrobbling] = enableScrobbling
        defaults[Self.key_enableLoveUnlove] = enableLoveUnlove
    }
    
    func persistSessionKey(to defaults: UserDefaults) {
        defaults[Self.key_sessionKey] = sessionKey
    }
}
