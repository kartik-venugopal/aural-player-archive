//
//  PersistentModelObject.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//

///
/// Protocol that marks an object as having state that must be persisted upon app exit.
///
protocol PersistentModelObject {
    
    associatedtype T: Codable
    
    // Retrieves persistent state for this model object
    var persistentState: T {get}
}
