//
//  PresetsWrapper.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

protocol PresetsWrapperProtocol {
    
    var userDefinedPresets: [EffectsUnitPreset] {get}
    var systemDefinedPresets: [EffectsUnitPreset] {get}
    
    func preset(named name: String) -> EffectsUnitPreset?
    
    func deletePresets(atIndices indices: IndexSet)
    
    func renamePreset(named oldName: String, to newName: String)
    
    func presetExists(named name: String) -> Bool
}

class PresetsWrapper<T: EffectsUnitPreset, U: EffectsUnitPresets<T>>: PresetsWrapperProtocol {
    
    private let presets: U
    
    init(_ presets: U) {
        self.presets = presets
    }
    
    var userDefinedPresets: [EffectsUnitPreset] {
        return presets.userDefinedObjects
    }
    var systemDefinedPresets: [EffectsUnitPreset] {
        return presets.systemDefinedObjects
    }
    
    func preset(named name: String) -> EffectsUnitPreset? {
        return presets.object(named: name)
    }
    
    func deletePresets(atIndices indices: IndexSet) {
        _ = presets.deleteObjects(atIndices: indices)
    }
    
    func renamePreset(named oldName: String, to newName: String) {
        presets.renameObject(named: oldName, to: newName)
    }
    
    func presetExists(named name: String) -> Bool {
        return presets.objectExists(named: name)
    }
}
