//
//  WindowedModePlaybackView.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  
import Cocoa

class WindowedModePlaybackView: PlaybackView, ColorSchemeable {
    
    private let fontSchemesManager: FontSchemesManager = objectGraph.fontSchemesManager
    private let colorSchemesManager: ColorSchemesManager = objectGraph.colorSchemesManager
    
    // When the buttons are in an "Off" state, they should be tinted according to the system color scheme's off state button color.
    override var offStateTintFunction: TintFunction {{Colors.toggleButtonOffStateColor}}

    // When the buttons are in an "On" state, they should be tinted according to the system color scheme's function button color.
    override var onStateTintFunction: TintFunction {{Colors.functionButtonColor}}
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        applyTheme()
    }
    
    func applyTheme() {
        
        applyFontScheme(fontSchemesManager.systemScheme)
        applyColorScheme(colorSchemesManager.systemScheme)
    }
    
    // Positions the "seek position marker" view at the center of the seek slider knob.
    func positionSeekPositionMarkerView() {
        (sliderView as? WindowedModeSeekSliderView)?.positionSeekPositionMarkerView()
    }
    
    var seekPositionMarker: NSView! {(sliderView as? WindowedModeSeekSliderView)?.seekPositionMarker}
}
