//
//  ObjectGraph.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

///
/// (Lazily) Initializes all the core objects and state required by the application (mostly singletons), and exposes them for application-wide
/// use as dependencies.
///
/// Acts as a simple alternative to a dependency injection framework / container.
///
class ObjectGraph {
    
    static let instance: ObjectGraph = .init()
    
    private let persistenceManager: PersistenceManager = PersistenceManager(persistentStateFile: FilesAndPaths.persistentStateFile)
    lazy var persistentState: AppPersistentState = persistenceManager.load(type: AppPersistentState.self) ?? .defaults
    
    let preferences: Preferences = Preferences(defaults: .standard)
    
    lazy var appModeManager: AppModeManager = AppModeManager(persistentState: persistentState.ui,
                                                             preferences: preferences.viewPreferences)
    
    private lazy var playlist: Playlist = Playlist(FlatPlaylist(),
                                                                 [GroupingPlaylist(.artists), GroupingPlaylist(.albums), GroupingPlaylist(.genres)])
    
//    lazy var playlistsManager: PlaylistsManager = {
//
//        let userPlaylistNames = (persistentState.playlist?.userPlaylists ?? []).compactMap {$0.name}
//
//        return PlaylistsManager(systemPlaylist: self.playlist,
//                                userPlaylists: userPlaylistNames.map {
//
//                                    Playlist(name: $0, userDefined: true, needsLoadingFromPersistentState: true, FlatPlaylist(),
//                                             [GroupingPlaylist(.artists), GroupingPlaylist(.albums), GroupingPlaylist(.genres)])
//                                })
//    }()
    
    lazy var playlistDelegate: PlaylistDelegateProtocol = PlaylistDelegate(persistentState: persistentState.playlist, playlist, playbackDelegate,
                                                                           trackReader, preferences)
    
    var playlistAccessorDelegate: PlaylistAccessorDelegateProtocol {playlistDelegate}
    
    lazy var audioUnitsManager: AudioUnitsManager = AudioUnitsManager()
    private lazy var audioEngine: AudioEngine = AudioEngine()
    
    lazy var audioGraph: AudioGraph = AudioGraph(audioEngine: audioEngine, audioUnitsManager: audioUnitsManager,
                                                         persistentState: persistentState.audioGraph)
    
    lazy var audioGraphDelegate: AudioGraphDelegateProtocol = AudioGraphDelegate(graph: audioGraph, persistentState: persistentState.audioGraph,
                                                                                 player: playbackDelegate, preferences: preferences.soundPreferences)
    
    private lazy var player: PlayerProtocol = Player(graph: audioGraph, avfScheduler: avfScheduler, ffmpegScheduler: ffmpegScheduler)
    private lazy var avfScheduler: PlaybackSchedulerProtocol = AVFScheduler(audioGraph.playerNode)
    
    private lazy var ffmpegScheduler: PlaybackSchedulerProtocol = FFmpegScheduler(playerNode: audioGraph.playerNode)
    private lazy var sequencer: Sequencer = {
        
        var playlistType: PlaylistType = .tracks
        
        if let viewString = persistentState.ui?.playlist?.view?.lowercased(), let view = PlaylistType(rawValue: viewString) {
            playlistType = view
        }
        
        return Sequencer(persistentState: persistentState.playbackSequence, playlist, playlistType)
    }()
    
    lazy var sequencerDelegate: SequencerDelegateProtocol = SequencerDelegate(sequencer)
    var sequencerInfoDelegate: SequencerInfoDelegateProtocol {sequencerDelegate}
    
    lazy var playbackDelegate: PlaybackDelegateProtocol = {
        
        let profiles = PlaybackProfiles(persistentState: persistentState.playbackProfiles ?? [])
        
        let startPlaybackChain = StartPlaybackChain(player, sequencer, playlist, trackReader: trackReader, profiles, preferences.playbackPreferences)
        let stopPlaybackChain = StopPlaybackChain(player, playlist, sequencer, profiles, preferences.playbackPreferences)
        let trackPlaybackCompletedChain = TrackPlaybackCompletedChain(startPlaybackChain, stopPlaybackChain, sequencer)
        
        // Playback Delegate
        return PlaybackDelegate(player, sequencer, profiles, preferences.playbackPreferences,
                                startPlaybackChain, stopPlaybackChain, trackPlaybackCompletedChain)
    }()
    
    var playbackInfoDelegate: PlaybackInfoDelegateProtocol {playbackDelegate}
    
    var historyDelegate: HistoryDelegateProtocol {_historyDelegate}
    private lazy var _historyDelegate: HistoryDelegate = HistoryDelegate(persistentState: persistentState.history, preferences.historyPreferences, playlistDelegate, playbackDelegate)
    
    var favoritesDelegate: FavoritesDelegateProtocol {_favoritesDelegate}
    private lazy var _favoritesDelegate: FavoritesDelegate = FavoritesDelegate(persistentState: persistentState.favorites, playlistDelegate,
                                                                                playbackDelegate)
    
    var bookmarksDelegate: BookmarksDelegateProtocol {_bookmarksDelegate}
    private lazy var _bookmarksDelegate: BookmarksDelegate = BookmarksDelegate(persistentState: persistentState.bookmarks, playlistDelegate,
                                                                                playbackDelegate)
    
    lazy var fileReader: FileReader = FileReader()
    lazy var trackReader: TrackReader = TrackReader(fileReader, coverArtReader)
    
    lazy var coverArtReader: CoverArtReader = CoverArtReader(fileCoverArtReader, musicBrainzCoverArtReader)
    lazy var fileCoverArtReader: FileCoverArtReader = FileCoverArtReader(fileReader)
    lazy var musicBrainzCoverArtReader: MusicBrainzCoverArtReader = MusicBrainzCoverArtReader(preferences: preferences.metadataPreferences,
                                                                                                cache: musicBrainzCache)
    
    lazy var musicBrainzCache: MusicBrainzCache = MusicBrainzCache(state: persistentState.musicBrainzCache,
                                                                     preferences: preferences.metadataPreferences.musicBrainz)
    
    lazy var lastFMCache: LastFMScrobbleCache = .init(persistentState: persistentState.lastFMCache)
    lazy var lastFMClient: LastFM_WSClientProtocol = LastFM_WSClient(cache: lastFMCache)
    
    lazy var windowLayoutsManager: WindowLayoutsManager = WindowLayoutsManager(persistentState: persistentState.ui?.windowLayout,
                                                                                 viewPreferences: preferences.viewPreferences)
    
    lazy var themesManager: ThemesManager = ThemesManager(persistentState: persistentState.ui?.themes, fontSchemesManager: fontSchemesManager)
    lazy var fontSchemesManager: FontSchemesManager = FontSchemesManager(persistentState: persistentState.ui?.fontSchemes)
    lazy var colorSchemesManager: ColorSchemesManager = ColorSchemesManager(persistentState: persistentState.ui?.colorSchemes)
    
    lazy var playerUIState: PlayerUIState = PlayerUIState(persistentState: persistentState.ui?.player)
    lazy var playlistUIState: PlaylistUIState = PlaylistUIState(persistentState: persistentState.ui?.playlist)
    lazy var menuBarPlayerUIState: MenuBarPlayerUIState = MenuBarPlayerUIState(persistentState: persistentState.ui?.menuBarPlayer)
    lazy var controlBarPlayerUIState: ControlBarPlayerUIState = ControlBarPlayerUIState(persistentState: persistentState.ui?.controlBarPlayer)
    lazy var visualizerUIState: VisualizerUIState = VisualizerUIState(persistentState: persistentState.ui?.visualizer)
    lazy var windowAppearanceState: WindowAppearanceState = WindowAppearanceState(persistentState: persistentState.ui?.windowAppearance)
    
    let mediaKeyHandler: MediaKeyHandler
    
    let fft: FFT = FFT()
    
    @available(OSX 10.12.2, *)
    lazy var remoteControlManager: RemoteControlManager = RemoteControlManager(playbackInfo: playbackInfoDelegate, audioGraph: audioGraphDelegate,
                                                                               sequencer: sequencerDelegate, preferences: preferences)
    
    lazy var cliCommandProcessor: CLICommandProcessor = .shared
    
    /// Measured in seconds
    private static let persistenceTaskInterval: Int = 60
    
    private lazy var persistenceTaskExecutor = RepeatingTaskExecutor(intervalMillis: Self.persistenceTaskInterval * 1000,
                                                                     task: savePersistentState,
                                                                     queue: .global(qos: .background))
    
    // Performs all necessary object initialization
    private init() {
        
         // Force initialization of objects that would not be initialized soon enough otherwise
        // (they are not referred to in code that is executed on app startup).
        
        self.mediaKeyHandler = MediaKeyHandler(preferences.controlsPreferences.mediaKeys)
        
        _ = remoteControlManager
        _ = lastFMClient
        
        DispatchQueue.global(qos: .background).async {
            self.cleanUpLegacyFolders()
        }
    }
    
    ///
    /// Clean up (delete) file system folders that were used by previous app versions that had the transcoder and/or recorder.
    ///
    private func cleanUpLegacyFolders() {
        
        let transcoderDir = FilesAndPaths.subDirectory(named: "transcoderStore")
        let artDir = FilesAndPaths.subDirectory(named: "albumArt")
        let recordingsDir = FilesAndPaths.subDirectory(named: "recordings")
        
        for folder in [transcoderDir, artDir, recordingsDir] {
            folder.delete()
        }
    }
    
    private lazy var tearDownOpQueue: OperationQueue = OperationQueue(opCount: 2, qos: .userInteractive)
    private lazy var recurringPersistenceOpQueue: OperationQueue = OperationQueue(opCount: 1, qos: .background)
    
    func beginPeriodicPersistence() {
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + Double(Self.persistenceTaskInterval)) {
            self.persistenceTaskExecutor.startOrResume()
        }
    }
    
    private func savePersistentState() {
        
        // Gather all pieces of persistent state into the persistentState object
        var persistentState: AppPersistentState = AppPersistentState()
        
        persistentState.appVersion = NSApp.appVersion
        
        persistentState.audioGraph = audioGraph.persistentState
        persistentState.playlist = playlist.persistentState
        persistentState.playbackSequence = sequencer.persistentState
        persistentState.playbackProfiles = playbackDelegate.profiles.all().map {PlaybackProfilePersistentState(profile: $0)}
        
        persistentState.history = _historyDelegate.persistentState
        persistentState.favorites = _favoritesDelegate.persistentState
        persistentState.bookmarks = _bookmarksDelegate.persistentState
        persistentState.musicBrainzCache = musicBrainzCache.persistentState
        persistentState.lastFMCache = lastFMCache.persistentState
        
        var windowLayoutsState = WindowLayoutsPersistentState(showEffects: true, showPlaylist: true,
                                                              mainWindowOrigin: .zero, effectsWindowOrigin: .zero, playlistWindowFrame: .zero,
                                                              userLayouts: [])
        
        // Grab window layouts state on the main thread.
        DispatchQueue.main.async {
            windowLayoutsState = self.windowLayoutsManager.persistentState
        }
        
        // Wait a bit for the main thread task to finish.
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
            
            persistentState.ui = UIPersistentState(appMode: self.appModeManager.currentMode,
                                                   windowLayout: windowLayoutsState,
                                                   themes: self.themesManager.persistentState,
                                                   fontSchemes: self.fontSchemesManager.persistentState,
                                                   colorSchemes: self.colorSchemesManager.persistentState,
                                                   player: self.playerUIState.persistentState,
                                                   playlist: self.playlistUIState.persistentState,
                                                   visualizer: self.visualizerUIState.persistentState,
                                                   windowAppearance: self.windowAppearanceState.persistentState,
                                                   menuBarPlayer: self.menuBarPlayerUIState.persistentState,
                                                   controlBarPlayer: self.controlBarPlayerUIState.persistentState)
            
            // Make sure app is not tearing down ! If it is, do nothing here.
            if self.tearDownOpQueue.operationCount == 0 {
                
                self.recurringPersistenceOpQueue.addOperation {
                    self.persistenceManager.save(persistentState)
                }
            }
        }
    }
    
    // Called when app exits
    func tearDown() {
        
        // App state persistence and shutting down the audio engine can be performed concurrently
        // on two background threads to save some time when exiting the app.
        
        // Gather all pieces of persistent state into the persistentState object
        var persistentState: AppPersistentState = AppPersistentState()
        
        persistentState.appVersion = NSApp.appVersion
        
        persistentState.audioGraph = audioGraph.persistentState
        persistentState.playlist = playlist.persistentState
        persistentState.playbackSequence = sequencer.persistentState
        persistentState.playbackProfiles = playbackDelegate.profiles.all().map {PlaybackProfilePersistentState(profile: $0)}
        
        persistentState.history = _historyDelegate.persistentState
        persistentState.favorites = _favoritesDelegate.persistentState
        persistentState.bookmarks = _bookmarksDelegate.persistentState
        persistentState.musicBrainzCache = musicBrainzCache.persistentState
        persistentState.lastFMCache = lastFMCache.persistentState
        
        persistentState.ui = UIPersistentState(appMode: appModeManager.currentMode,
                                               windowLayout: windowLayoutsManager.persistentState,
                                               themes: themesManager.persistentState,
                                               fontSchemes: fontSchemesManager.persistentState,
                                               colorSchemes: colorSchemesManager.persistentState,
                                               player: playerUIState.persistentState,
                                               playlist: playlistUIState.persistentState,
                                               visualizer: visualizerUIState.persistentState,
                                               windowAppearance: windowAppearanceState.persistentState,
                                               menuBarPlayer: menuBarPlayerUIState.persistentState,
                                               controlBarPlayer: controlBarPlayerUIState.persistentState)
        
        tearDownOpQueue.addOperations([
            
            // Persist app state to disk.
            BlockOperation {
                
                if self.recurringPersistenceOpQueue.operationCount == 0 {
                    
                    // If the recurring persistence task is not running, save state normally.
                    self.persistenceManager.save(persistentState)
                    
                } else {
                    
                    // If the recurring persistence task is running, just wait for it to finish.
                    self.recurringPersistenceOpQueue.waitUntilAllOperationsAreFinished()
                }
            },
            
            // Tear down the player and audio engine.
            BlockOperation {
                
                self.player.tearDown()
                self.audioGraph.tearDown()
            }
            
        ], waitUntilFinished: true)
    }
}
