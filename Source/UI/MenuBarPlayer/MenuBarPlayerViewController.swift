//
//  MenuBarPlayerViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

class MenuBarPlayerViewController: NSViewController, Destroyable {

    override var nibName: String? {"MenuBarPlayer"}
    
    @IBOutlet weak var appLogo: TintedImageView!
    @IBOutlet weak var btnQuit: TintedImageButton!
    @IBOutlet weak var btnWindowedMode: TintedImageButton!
    @IBOutlet weak var btnControlBarMode: TintedImageButton!
    
    @IBOutlet weak var infoBox: NSBox!
    @IBOutlet weak var trackInfoView: MenuBarPlayingTrackTextView!
    @IBOutlet weak var imgArt: NSImageView!
    @IBOutlet weak var artOverlayBox: NSBox!
    
    @IBOutlet weak var playbackView: MenuBarPlaybackView!
    @IBOutlet weak var seekSliderView: MenuBarSeekSliderView!
    
    @IBOutlet weak var btnSettings: TintedImageButton!
    @IBOutlet weak var settingsBox: NSBox!
    
    @IBOutlet weak var playbackViewController: MenuBarPlaybackViewController!
    @IBOutlet weak var audioViewController: MenuBarPlayerAudioViewController!
    @IBOutlet weak var sequencingViewController: MenuBarPlayerSequencingViewController!
    
    // Delegate that conveys all playback requests to the player / playback sequencer
    private let player: PlaybackDelegateProtocol = objectGraph.playbackDelegate
    
    private lazy var uiState: MenuBarPlayerUIState = objectGraph.menuBarPlayerUIState
    
    private lazy var messenger = Messenger(for: self)
    
    override func awakeFromNib() {
        
        [btnQuit, btnWindowedMode, btnControlBarMode, btnSettings].forEach {$0?.tintFunction = {.white70Percent}}
        
        appLogo.tintFunction = {.white70Percent}

        // MARK: Notification subscriptions
        
        messenger.subscribeAsync(to: .player_trackTransitioned, handler: trackTransitioned(_:))
        messenger.subscribeAsync(to: .player_trackInfoUpdated, handler: trackInfoUpdated(_:))
        messenger.subscribe(to: .player_chapterChanged, handler: chapterChanged(_:))
        messenger.subscribeAsync(to: .player_trackNotPlayed, handler: trackNotPlayed(_:))
    }
    
    func destroy() {
        
        [playbackViewController, audioViewController, sequencingViewController].forEach {
            ($0 as? Destroyable)?.destroy()
        }
        
        messenger.unsubscribeFromAll()
    }
    
    override func viewDidLoad() {
        
        updateTrackInfo()

        // When the view first loads, the menu bar's menu is closed (not visible), so
        // don't bother updating the seek position unnecessarily.
        if view.superview == nil {
            seekSliderView.stopUpdatingSeekPosition()
        }
    }
    
    // MARK: Track playback actions/functions ------------------------------------------------------------
    
    private func updateTrackInfo() {
        
        if let theTrack = player.playingTrack {
            trackInfoView.trackInfo = PlayingTrackInfo(theTrack, player.playingChapter?.chapter.title)
            
        } else {
            trackInfoView.trackInfo = nil
        }
        
        imgArt.image = player.playingTrack?.art?.image
        [imgArt, artOverlayBox].forEach {$0?.showIf(imgArt.image != nil && uiState.showAlbumArt)}
        
        infoBox.bringToFront()
        
        if settingsBox.isShown {
            settingsBox.bringToFront()
        }
    }
    
    @IBAction func showOrHideSettingsAction(_ sender: NSButton) {
        
        if settingsBox.isHidden {

            settingsBox.show()
            settingsBox.bringToFront()

        } else {
            
            settingsBox.hide()
            infoBox.bringToFront()
        }
    }
    
    func menuBarMenuOpened() {
        
        if settingsBox.isShown {
            
            settingsBox.hide()
            infoBox.bringToFront()
        }
        
        // If the player is playing, we need to resume updating the seek
        // position as the view is now visible.
        if player.state == .playing {
            seekSliderView.resumeUpdatingSeekPosition()
        } else {
            seekSliderView.updateSeekPosition()
        }
    }
    
    func menuBarMenuClosed() {
        
        if settingsBox.isShown {
            
            settingsBox.hide()
            infoBox.bringToFront()
        }
        
        // Updating seek position is not necessary when the view has been closed.
        seekSliderView.stopUpdatingSeekPosition()
    }
    
    // MARK: Message handling

    func trackTransitioned(_ notification: TrackTransitionNotification) {
        updateTrackInfo()
    }
    
    // When track info for the playing track changes, display fields need to be updated
    func trackInfoUpdated(_ notification: TrackInfoUpdatedNotification) {
        
        if notification.updatedTrack == player.playingTrack {
            updateTrackInfo()
        }
    }
    
    func chapterChanged(_ notification: ChapterChangedNotification) {
        
        if let playingTrack = player.playingTrack {
            trackInfoView.trackInfo = PlayingTrackInfo(playingTrack, notification.newChapter?.chapter.title)
        }
    }
    
    func trackNotPlayed(_ notification: TrackNotPlayedNotification) {
        
        updateTrackInfo()
        
        let errorDialog = DialogsAndAlerts.genericErrorAlert("Track not played",
                                                             notification.errorTrack.file.lastPathComponent,
                                                             notification.error.message)
            
        errorDialog.runModal()
    }
    
    @IBAction func windowedModeAction(_ sender: AnyObject) {
        messenger.publish(.application_switchMode, payload: AppMode.windowed)
    }
    
    @IBAction func controlBarModeAction(_ sender: AnyObject) {
        messenger.publish(.application_switchMode, payload: AppMode.controlBar)
    }

    @IBAction func quitAction(_ sender: AnyObject) {
        NSApp.terminate(self)
    }
}
