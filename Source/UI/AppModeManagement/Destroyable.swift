//
//  Destroyable.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//

protocol Destroyable {
    
    func destroy()
    
    static func destroy()
}

extension Destroyable {
    
    func destroy() {}
    
    static func destroy() {}
}
