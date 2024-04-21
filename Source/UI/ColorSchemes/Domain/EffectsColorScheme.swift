//
//  EffectsColorScheme.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  

import Cocoa

/*
    Encapsulates color values that are applicable to the effects panel UI, e.g. color of the sliders.
 */
class EffectsColorScheme {
    
    var functionCaptionTextColor: NSColor
    var functionValueTextColor: NSColor
    
    var sliderBackgroundColor: NSColor
    var sliderBackgroundGradientType: ColorSchemeGradientType
    var sliderBackgroundGradientAmount: Int
    
    var sliderForegroundGradientType: ColorSchemeGradientType
    var sliderForegroundGradientAmount: Int
    
    var sliderKnobColor: NSColor
    var sliderKnobColorSameAsForeground: Bool
    
    var sliderTickColor: NSColor
    
    var activeUnitStateColor: NSColor
    var bypassedUnitStateColor: NSColor
    var suppressedUnitStateColor: NSColor
    
    init(_ persistentState: EffectsColorSchemePersistentState?) {
        
        self.functionCaptionTextColor = persistentState?.functionCaptionTextColor?.toColor() ?? ColorScheme.defaultScheme.effects.functionCaptionTextColor
        self.functionValueTextColor = persistentState?.functionValueTextColor?.toColor() ?? ColorScheme.defaultScheme.effects.functionValueTextColor
        
        self.sliderBackgroundColor = persistentState?.sliderBackgroundColor?.toColor() ?? ColorScheme.defaultScheme.effects.sliderBackgroundColor
        self.sliderBackgroundGradientType = persistentState?.sliderBackgroundGradientType ?? ColorScheme.defaultScheme.effects.sliderBackgroundGradientType
        self.sliderBackgroundGradientAmount = persistentState?.sliderBackgroundGradientAmount ?? ColorScheme.defaultScheme.effects.sliderBackgroundGradientAmount
        
        self.sliderForegroundGradientType = persistentState?.sliderForegroundGradientType ?? ColorScheme.defaultScheme.effects.sliderForegroundGradientType
        self.sliderForegroundGradientAmount = persistentState?.sliderForegroundGradientAmount ?? ColorScheme.defaultScheme.effects.sliderForegroundGradientAmount
        
        self.sliderKnobColor = persistentState?.sliderKnobColor?.toColor() ?? ColorScheme.defaultScheme.effects.sliderKnobColor
        self.sliderKnobColorSameAsForeground = persistentState?.sliderKnobColorSameAsForeground ?? ColorScheme.defaultScheme.effects.sliderKnobColorSameAsForeground
        
        self.sliderTickColor = persistentState?.sliderTickColor?.toColor() ?? ColorScheme.defaultScheme.effects.sliderTickColor
        
        self.activeUnitStateColor = persistentState?.activeUnitStateColor?.toColor() ?? ColorScheme.defaultScheme.effects.activeUnitStateColor
        self.bypassedUnitStateColor = persistentState?.bypassedUnitStateColor?.toColor() ?? ColorScheme.defaultScheme.effects.bypassedUnitStateColor
        self.suppressedUnitStateColor = persistentState?.suppressedUnitStateColor?.toColor() ?? ColorScheme.defaultScheme.effects.suppressedUnitStateColor
    }
    
    init(_ scheme: EffectsColorScheme) {
        
        self.functionCaptionTextColor = scheme.functionCaptionTextColor
        self.functionValueTextColor = scheme.functionValueTextColor
        
        self.sliderBackgroundColor = scheme.sliderBackgroundColor
        self.sliderBackgroundGradientType = scheme.sliderBackgroundGradientType
        self.sliderBackgroundGradientAmount = scheme.sliderBackgroundGradientAmount
        
        self.sliderForegroundGradientType = scheme.sliderForegroundGradientType
        self.sliderForegroundGradientAmount = scheme.sliderForegroundGradientAmount
        
        self.sliderKnobColor = scheme.sliderKnobColor
        self.sliderKnobColorSameAsForeground = scheme.sliderKnobColorSameAsForeground
        
        self.sliderTickColor = scheme.sliderTickColor
        
        self.activeUnitStateColor = scheme.activeUnitStateColor
        self.bypassedUnitStateColor = scheme.bypassedUnitStateColor
        self.suppressedUnitStateColor = scheme.suppressedUnitStateColor
    }
    
    init(_ preset: ColorSchemePreset) {
        
        self.functionCaptionTextColor = preset.effectsFunctionCaptionTextColor
        self.functionValueTextColor = preset.effectsFunctionValueTextColor
        
        self.sliderBackgroundColor = preset.effectsSliderBackgroundColor
        self.sliderBackgroundGradientType = preset.effectsSliderBackgroundGradientType
        self.sliderBackgroundGradientAmount = preset.effectsSliderBackgroundGradientAmount
        
        self.sliderForegroundGradientType = preset.effectsSliderForegroundGradientType
        self.sliderForegroundGradientAmount = preset.effectsSliderForegroundGradientAmount
        
        self.sliderKnobColor = preset.effectsSliderKnobColor
        self.sliderKnobColorSameAsForeground = preset.effectsSliderKnobColorSameAsForeground
        
        self.sliderTickColor = preset.effectsSliderTickColor
        
        self.activeUnitStateColor = preset.effectsActiveUnitStateColor
        self.bypassedUnitStateColor = preset.effectsBypassedUnitStateColor
        self.suppressedUnitStateColor = preset.effectsSuppressedUnitStateColor
    }
    
    func applyPreset(_ preset: ColorSchemePreset) {

        self.functionCaptionTextColor = preset.effectsFunctionCaptionTextColor
        self.functionValueTextColor = preset.effectsFunctionValueTextColor
        
        self.sliderBackgroundColor = preset.effectsSliderBackgroundColor
        self.sliderBackgroundGradientType = preset.effectsSliderBackgroundGradientType
        self.sliderBackgroundGradientAmount = preset.effectsSliderBackgroundGradientAmount
        
        self.sliderForegroundGradientType = preset.effectsSliderForegroundGradientType
        self.sliderForegroundGradientAmount = preset.effectsSliderForegroundGradientAmount
        
        self.sliderKnobColor = preset.effectsSliderKnobColor
        self.sliderKnobColorSameAsForeground = preset.effectsSliderKnobColorSameAsForeground
        
        self.sliderTickColor = preset.effectsSliderTickColor
        
        self.activeUnitStateColor = preset.effectsActiveUnitStateColor
        self.bypassedUnitStateColor = preset.effectsBypassedUnitStateColor
        self.suppressedUnitStateColor = preset.effectsSuppressedUnitStateColor
    }
    
    func applyScheme(_ scheme: EffectsColorScheme) {
        
        self.functionCaptionTextColor = scheme.functionCaptionTextColor
        self.functionValueTextColor = scheme.functionValueTextColor
        
        self.sliderBackgroundColor = scheme.sliderBackgroundColor
        self.sliderBackgroundGradientType = scheme.sliderBackgroundGradientType
        self.sliderBackgroundGradientAmount = scheme.sliderBackgroundGradientAmount
        
        self.sliderForegroundGradientType = scheme.sliderForegroundGradientType
        self.sliderForegroundGradientAmount = scheme.sliderForegroundGradientAmount
        
        self.sliderKnobColor = scheme.sliderKnobColor
        self.sliderKnobColorSameAsForeground = scheme.sliderKnobColorSameAsForeground
        
        self.sliderTickColor = scheme.sliderTickColor
        
        self.activeUnitStateColor = scheme.activeUnitStateColor
        self.bypassedUnitStateColor = scheme.bypassedUnitStateColor
        self.suppressedUnitStateColor = scheme.suppressedUnitStateColor
    }
    
    func clone() -> EffectsColorScheme {
        return EffectsColorScheme(self)
    }
    
    var persistentState: EffectsColorSchemePersistentState {
        return EffectsColorSchemePersistentState(self)
    }
}
