//
//  PersistentPreferencesProtocol.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  
import Foundation

///
/// Contract for a persistent preferences object.
///
protocol PersistentPreferencesProtocol {
    
    init(_ dict: [String: Any])
    
    func persist(to defaults: UserDefaults)
}
