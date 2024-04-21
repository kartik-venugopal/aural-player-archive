//
//  AudioUnitPersistentState.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation
import AudioToolbox

///
/// Persistent state for an effects unit that hosts an Audio Units (AU) plug-in.
///
/// - SeeAlso:  `HostedAudioUnit`
///
struct AudioUnitPersistentState: Codable {
    
    let state: EffectsUnitState?
    let renderQuality: Int?

    let componentType: OSType?
    let componentSubType: OSType?
    let params: [AudioUnitParameterPersistentState]?
}

///
/// Persistent state for a single Hosted Audio Unit effects parameter.
///
struct AudioUnitParameterPersistentState: Codable {
    
    let address: UInt64?
    let value: Float?
}

///
/// Persistent state for a single Hosted Audio Unit effects preset.
///
/// - SeeAlso:  `AudioUnitPreset`
///
struct AudioUnitPresetPersistentState: Codable {
    
    let name: String?
    let state: EffectsUnitState?
    
    let componentType: OSType?
    let componentSubType: OSType?
    
    let parameterValues: [AUParameterAddress: Float]?
    
    init(preset: AudioUnitPreset) {
        
        self.name = preset.name
        self.state = preset.state
        
        self.componentType = preset.componentType
        self.componentSubType = preset.componentSubType
        
        self.parameterValues = preset.parameterValues
    }
}

struct AudioUnitPresetsPersistentState: Codable {
    
    let presets: [OSType: [OSType: [AudioUnitPresetPersistentState]]]?
}
