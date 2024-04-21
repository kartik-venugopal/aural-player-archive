//
//  MasterUnit.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

protocol MasterUnitProtocol: EffectsUnitProtocol {}

///
/// A "master" effects unit that does not directly manipulate audio, but
/// controls all other ("slave") effects units that do manipulate audio.
///
/// This unit provides 2 main functions:
/// 1. Acts as a "master on/off switch" to enable / disable all effects at once.
/// 2. Provides a way to capture all audio effects in a single preset object that can be saved and reused.
///
class MasterUnit: EffectsUnit, MasterUnitProtocol {
    
    let presets: MasterPresets
    var currentPreset: MasterPreset? = nil
    
    var eqUnit: EQUnit
    var pitchShiftUnit: PitchShiftUnit
    var timeStretchUnit: TimeStretchUnit
    var reverbUnit: ReverbUnit
    var delayUnit: DelayUnit
    var filterUnit: FilterUnit
    
    var nativeSlaveUnits: [EffectsUnit]
    var audioUnits: [HostedAudioUnit]

    init(persistentState: MasterUnitPersistentState?, nativeSlaveUnits: [EffectsUnit], audioUnits: [HostedAudioUnit]) {
        
        self.nativeSlaveUnits = nativeSlaveUnits
        
        eqUnit = nativeSlaveUnits.first(where: {$0 is EQUnit}) as! EQUnit
        pitchShiftUnit = nativeSlaveUnits.first(where: {$0 is PitchShiftUnit}) as! PitchShiftUnit
        timeStretchUnit = nativeSlaveUnits.first(where: {$0 is TimeStretchUnit}) as! TimeStretchUnit
        reverbUnit = nativeSlaveUnits.first(where: {$0 is ReverbUnit}) as! ReverbUnit
        delayUnit = nativeSlaveUnits.first(where: {$0 is DelayUnit}) as! DelayUnit
        filterUnit = nativeSlaveUnits.first(where: {$0 is FilterUnit}) as! FilterUnit
        
        self.audioUnits = audioUnits
        presets = MasterPresets(persistentState: persistentState)
        
        super.init(unitType: .master, unitState: persistentState?.state ?? AudioGraphDefaults.masterState)
        
        messenger.subscribe(to: .effects_unitActivated, handler: ensureActive)
        
        if let currentPresetName = persistentState?.currentPresetName,
            let matchingPreset = presets.object(named: currentPresetName) {
            
            currentPreset = matchingPreset
        }
        
        presets.registerPresetDeletionCallback(presetsDeleted(_:))
        
        unitInitialized = true
    }
    
    override func toggleState() -> EffectsUnitState {
        
        if super.toggleState() == .bypassed {

            // Active -> Inactive
            // If a unit was active (i.e. not bypassed), deactivate it (mark it as
            // now being suppressed by the master bypass).
            
            nativeSlaveUnits.forEach {$0.suppress()}
            audioUnits.forEach {$0.suppress()}
            
        } else {
            
            // Inactive -> Active
            // If a unit was inactive (i.e. bypassed), activate it.
            
            nativeSlaveUnits.forEach {$0.unsuppress()}
            audioUnits.forEach {$0.unsuppress()}
        }
        
        return state
    }
    
    override func savePreset(named presetName: String) {
        
        let masterPreset = settingsAsPreset
        masterPreset.nameOfCurrentMasterPreset = nil    // This field is only used with sound profiles
        
        masterPreset.name = presetName
        masterPreset.eq.name = "EQ settings for Master preset: '\(presetName)'"
        masterPreset.pitch.name = "Pitch settings for Master preset: '\(presetName)'"
        masterPreset.time.name = "Time settings for Master preset: '\(presetName)'"
        masterPreset.reverb.name = "Reverb settings for Master preset: '\(presetName)'"
        masterPreset.delay.name = "Delay settings for Master preset: '\(presetName)'"
        masterPreset.filter.name = "Filter settings for Master preset: '\(presetName)'"
        
        // Save the new preset
        presets.addObject(masterPreset)
        currentPreset = masterPreset
    }
    
    var settingsAsPreset: MasterPreset {
        
        let eqPreset = eqUnit.settingsAsPreset
        let pitchPreset = pitchShiftUnit.settingsAsPreset
        let timePreset = timeStretchUnit.settingsAsPreset
        let reverbPreset = reverbUnit.settingsAsPreset
        let delayPreset = delayUnit.settingsAsPreset
        let filterPreset = filterUnit.settingsAsPreset
        
        return MasterPreset(name: "masterSettings", eq: eqPreset, pitch: pitchPreset,
                            time: timePreset, reverb: reverbPreset, delay: delayPreset,
                            filter: filterPreset,
                            nameOfCurrentMasterPreset: currentPreset?.name,
                            nameOfCurrentEQPreset: eqUnit.currentPreset?.name,
                            nameOfCurrentPitchShiftPreset: pitchShiftUnit.currentPreset?.name,
                            nameOfCurrentTimeStretchPreset: timeStretchUnit.currentPreset?.name,
                            nameOfCurrentReverbPreset: reverbUnit.currentPreset?.name,
                            nameOfCurrentDelayPreset: delayUnit.currentPreset?.name,
                            nameOfCurrentFilterPreset: filterUnit.currentPreset?.name,
                            systemDefined: false)
    }
    
    override func applyPreset(named presetName: String) {
        
        if let preset = presets.object(named: presetName) {
            
            applyPreset(preset)
            currentPreset = preset
        }
    }
    
    func applyPreset(_ preset: MasterPreset) {
        
        eqUnit.applyPreset(preset.eq)
        eqUnit.state = preset.eq.state
        
        if let nameOfCurrentEQPreset = preset.nameOfCurrentEQPreset {
            eqUnit.setCurrentPreset(byName: nameOfCurrentEQPreset)
        }
        
        pitchShiftUnit.applyPreset(preset.pitch)
        pitchShiftUnit.state = preset.pitch.state
        
        if let nameOfCurrentPitchShiftPreset = preset.nameOfCurrentPitchShiftPreset {
            pitchShiftUnit.setCurrentPreset(byName: nameOfCurrentPitchShiftPreset)
        }
        
        timeStretchUnit.applyPreset(preset.time)
        timeStretchUnit.state = preset.time.state
        
        if let nameOfCurrentTimeStretchPreset = preset.nameOfCurrentTimeStretchPreset {
            timeStretchUnit.setCurrentPreset(byName: nameOfCurrentTimeStretchPreset)
        }
        
        reverbUnit.applyPreset(preset.reverb)
        reverbUnit.state = preset.reverb.state
        
        if let nameOfCurrentReverbPreset = preset.nameOfCurrentReverbPreset {
            reverbUnit.setCurrentPreset(byName: nameOfCurrentReverbPreset)
        }
        
        delayUnit.applyPreset(preset.delay)
        delayUnit.state = preset.delay.state
        
        if let nameOfCurrentDelayPreset = preset.nameOfCurrentDelayPreset {
            delayUnit.setCurrentPreset(byName: nameOfCurrentDelayPreset)
        }
        
        filterUnit.applyPreset(preset.filter)
        filterUnit.state = preset.filter.state
        
        if let nameOfCurrentFilterPreset = preset.nameOfCurrentFilterPreset {
            filterUnit.setCurrentPreset(byName: nameOfCurrentFilterPreset)
        }
        
        if let nameOfCurrentMasterPreset = preset.nameOfCurrentMasterPreset {
            self.setCurrentPreset(byName: nameOfCurrentMasterPreset)
        } else {
            currentPreset = nil
        }
    }
    
    func setCurrentPreset(byName presetName: String) {
        
        // TODO: Implement this !!!
        
        guard let matchingPreset = presets.object(named: presetName) else {return}
        
        if (matchingPreset.eq.state != eqUnit.state) ||
            (matchingPreset.pitch.state != pitchShiftUnit.state) ||
            (matchingPreset.time.state != timeStretchUnit.state) ||
            (matchingPreset.reverb.state != reverbUnit.state) ||
            (matchingPreset.delay.state != delayUnit.state) ||
            (matchingPreset.filter.state != filterUnit.state) {
            
            return
        }
        
        if !matchingPreset.eq.equalToOtherPreset(globalGain: eqUnit.globalGain, bands: eqUnit.bands) {
            return
        }
        
        if !matchingPreset.pitch.equalToOtherPreset(pitch: pitchShiftUnit.pitch) {
            return
        }
        
        if !matchingPreset.time.equalToOtherPreset(rate: timeStretchUnit.rate, shiftPitch: timeStretchUnit.shiftPitch) {
            return
        }
        
        if !matchingPreset.reverb.equalToOtherPreset(space: reverbUnit.space, amount: reverbUnit.amount) {
            return
        }
        
        if !matchingPreset.delay.equalToOtherPreset(amount: delayUnit.amount, time: delayUnit.time,
                                                    feedback: delayUnit.feedback, lowPassCutoff: delayUnit.lowPassCutoff) {
            return
        }
        
        if !matchingPreset.filter.equalToOtherPreset(bands: filterUnit.bands) {
            return
        }
        
        self.currentPreset = matchingPreset
    }
    
    private func presetsDeleted(_ presetNames: [String]) {
        
        if let theCurrentPreset = currentPreset, theCurrentPreset.userDefined, presetNames.contains(theCurrentPreset.name) {
            currentPreset = nil
        }
    }
    
    func addAudioUnit(_ unit: HostedAudioUnit) {
        audioUnits.append(unit)
    }
    
    func removeAudioUnits(at descendingIndices: [Int]) {
        descendingIndices.forEach {audioUnits.remove(at: $0)}
    }
    
    var persistentState: MasterUnitPersistentState {

        MasterUnitPersistentState(state: state,
                                  userPresets: presets.userDefinedObjects.map {MasterPresetPersistentState(preset: $0)},
                                  currentPresetName: currentPreset?.name)
    }
}
