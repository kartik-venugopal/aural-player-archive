//
//  EffectsUnitState.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// An enumeration of all possible states an effects unit can be in.
///
enum EffectsUnitState: String, CaseIterable, Codable {
    
    // Master unit on, and effects unit on
    case active
    
    // Effects unit off
    case bypassed
    
    // Master unit off, and effects unit on
    case suppressed
}

typealias EffectsUnitStateFunction = () -> EffectsUnitState
