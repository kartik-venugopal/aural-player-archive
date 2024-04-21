//
//  WindowedModePlayerAudioViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  
import Cocoa

class WindowedModePlayerAudioViewController: PlayerAudioViewController {
    
    override var showsPanControl: Bool {true}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        simpleControls = [btnSimpleVolume, simpleVolumeSlider]
        advancedControls = [btnAdvancedVolume, advancedVolumeSlider, lblPanCaption, lblPanCaption2, panSlider]
        
        changeControlsView(to: uiState.controlsViewType)
    }
    
    override func initSubscriptions() {
        
        // Subscribe to notifications
        messenger.subscribeAsync(to: .player_trackTransitioned, handler: trackTransitioned(_:),
                                 filter: {msg in msg.trackChanged})
        
        messenger.subscribe(to: .player_muteOrUnmute, handler: muteOrUnmute)
        messenger.subscribe(to: .player_mute, handler: mute)
        messenger.subscribe(to: .player_unmute, handler: unmute)
        
        messenger.subscribe(to: .player_decreaseVolume, handler: decreaseVolume(_:))
        messenger.subscribe(to: .player_increaseVolume, handler: increaseVolume(_:))
        messenger.subscribe(to: .player_setVolume, handler: setVolume(to:))
        
        messenger.subscribe(to: .player_panLeft, handler: panLeft)
        messenger.subscribe(to: .player_panRight, handler: panRight)
        
        messenger.subscribe(to: .player_changeControlsView, handler: changeControlsView(to:))
        
        messenger.subscribe(to: .applyTheme, handler: applyTheme)
        messenger.subscribe(to: .applyFontScheme, handler: applyFontScheme(_:))
        messenger.subscribe(to: .applyColorScheme, handler: applyColorScheme(_:))
        messenger.subscribe(to: .changeFunctionButtonColor, handler: changeFunctionButtonColor(_:))
        messenger.subscribe(to: .player_changeSliderColors, handler: changeSliderColors)
        messenger.subscribe(to: .player_changeSliderValueTextColor, handler: changeSliderValueTextColor(_:))
    }
}
