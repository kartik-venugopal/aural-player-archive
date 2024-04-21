//
//  ColorSchemePreset.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    Enumeration of all system-defined color schemes and all their color values.
 */
enum ColorSchemePreset: String, CaseIterable {
    
    // A dark scheme with a black background (the default scheme) and lighter foreground elements.
    case blackAttack
    
    // A light scheme with an off-white background and dark foreground elements.
    case whiteBlight
    
    // A dark scheme with a black background and aqua coloring of active sliders.
    case blackAqua
    
    case lava
    
    // A semi-dark scheme with a gray background and lighter foreground elements.
    case gloomyDay
    
    // A semi-dark scheme with a brown background and lighter reddish-brown foreground elements.
    case brownie
    
    // A moderately dark scheme with a blue-ish background and lighter blue-ish foreground elements.
    case theBlues
    
    case poolsideFM
    
    // The preset to be used as the default system scheme (eg. when a user loads the app for the very first time)
    // or when some color values in a scheme are missing.
    static var defaultScheme: ColorSchemePreset {
        return blackAttack
    }
    
    // Maps a display name to a preset.
    static func presetByName(_ name: String) -> ColorSchemePreset? {
        
        switch name {
            
        case ColorSchemePreset.blackAttack.name:    return .blackAttack
            
        case ColorSchemePreset.blackAqua.name:    return .blackAqua
            
        case ColorSchemePreset.lava.name:    return .lava
            
        case ColorSchemePreset.whiteBlight.name:    return .whiteBlight
            
        case ColorSchemePreset.gloomyDay.name:      return .gloomyDay
            
        case ColorSchemePreset.brownie.name:      return .brownie
            
        case ColorSchemePreset.theBlues.name:   return .theBlues
            
        case ColorSchemePreset.poolsideFM.name:   return .poolsideFM
            
        default:    return nil
            
        }
    }
    
    // Returns a user-friendly display name for this preset.
    var name: String {
        
        switch self {
            
        case .blackAttack:  return "Black attack (default)"
            
        case .blackAqua:    return "Black & aqua"
            
        case .lava:         return "Lava"
            
        case .whiteBlight:  return "White blight"
            
        case .gloomyDay:    return "Gloomy day"
            
        case .brownie:         return "Brownie"
            
        case .theBlues:     return "The blues"
            
        case .poolsideFM:     return "Poolside.fm"
            
        }
    }
    
    var appLogoColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:     return .white50Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:         return NSColor(red: 0.512, green: 0.388, blue: 0.354)
            
        case .theBlues:     return NSColor(red: 0.468, green: 0.572, blue: 0.569)
            
        case .poolsideFM:  return .black
            
        }
    }
    
    var backgroundColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white8Percent
            
        case .blackAqua:  return .white8Percent
            
        case .lava:     return NSColor(red: 0.144, green: 0.144, blue: 0.144)
            
        case .whiteBlight:  return .white75Percent
            
        case .gloomyDay:    return .white20Percent
            
        case .brownie:         return NSColor(red: 0.25, green: 0.162, blue: 0.131)
            
        case .theBlues:     return NSColor(red: 0.191, green: 0.274, blue: 0.361)
            
        case .poolsideFM:   return NSColor(red: 1, green: 0.7882353, blue: 0.7882353)
            
        }
    }
    
    var functionButtonColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white55Percent
            
        case .blackAqua:  return .white55Percent
            
        case .lava:     return .white55Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white55Percent
            
        case .brownie:      return NSColor(red: 0.636, green: 0.483, blue: 0.44)
            
        case .theBlues:     return NSColor(red: 0.423, green: 0.501, blue: 0.549)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var textButtonMenuColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white22Percent
            
        case .blackAqua:  return .white22Percent
            
        case .lava:     return .white22Percent
            
        case .whiteBlight:  return .white30Percent
            
        case .gloomyDay:    return .white8Percent
            
        case .brownie:         return NSColor(red: 0.5, green: 0.333, blue: 0.272)
            
        case .theBlues:     return NSColor(red: 0.17, green: 0.182, blue: 0.246)
            
        case .poolsideFM:   return .black
        
        }
    }
    
    var toggleButtonOffStateColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white25Percent
            
        case .blackAqua:  return .white25Percent
            
        case .lava:     return .white25Percent
            
        case .whiteBlight:  return .white40Percent
            
        case .gloomyDay:    return .white7Percent
            
        case .brownie:         return NSColor(red: 0.384, green: 0.292, blue: 0.266)
            
        case .theBlues:     return NSColor(white: 0.07)
            
        case .poolsideFM:   return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
    
    var mainCaptionTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white40Percent
            
        case .blackAqua:  return .white40Percent
            
        case .lava:     return .white40Percent
            
        case .whiteBlight:  return .white30Percent
            
        case .gloomyDay:    return .white45Percent
            
        case .brownie:         return NSColor(red: 0.536, green: 0.356, blue: 0.29)
            
        case .theBlues:     return NSColor(red: 0.429, green: 0.486, blue: 0.518)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var buttonMenuTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white75Percent
            
        case .blackAqua:  return .white75Percent
            
        case .lava:     return .white75Percent
            
        case .whiteBlight:  return .white
            
        case .gloomyDay:    return .white75Percent
            
        case .brownie:    return NSColor(red: 0.951, green: 0.631, blue: 0.515)
            
        case .theBlues:     return NSColor(red: 0.617, green: 0.7, blue: 0.746)
            
        case .poolsideFM:   return .white
            
        }
    }
    
    var selectedTabButtonColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:     return .white50Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.701, green: 0.465, blue: 0.38)
            
        case .theBlues:     return NSColor(red: 0.505, green: 0.596, blue: 0.654)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var tabButtonTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white40Percent
            
        case .blackAqua:  return .white40Percent
            
        case .lava:     return .white40Percent
            
        case .whiteBlight:  return .white15Percent
            
        case .gloomyDay:    return .white45Percent
            
        case .brownie:    return NSColor(red: 0.536, green: 0.356, blue: 0.29)
            
        case .theBlues:     return NSColor(red: 0.429, green: 0.486, blue: 0.518)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var selectedTabButtonTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white70Percent
            
        case .blackAqua:  return .white70Percent
            
        case .lava:     return .white70Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white70Percent
            
        case .brownie:    return NSColor(red: 0.701, green: 0.465, blue: 0.38)
            
        case .theBlues:     return NSColor(red: 0.564, green: 0.64, blue: 0.682)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    // MARK: Player colors -------------------------------------------------------------------------------------------------------------------
    
    var playerTrackInfoPrimaryTextColor: NSColor {
        
        switch self {
        
        case .blackAttack:  return .white80Percent
            
        case .blackAqua:  return .white80Percent
            
        case .lava:     return .white80Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white80Percent
            
        case .brownie:    return NSColor(red: 0.946, green: 0.628, blue: 0.513)
            
        case .theBlues:     return NSColor(red: 0.693, green: 0.787, blue: 0.837)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playerTrackInfoSecondaryTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white65Percent
            
        case .blackAqua:  return .white65Percent
            
        case .lava:     return .white65Percent
            
        case .whiteBlight:  return .white15Percent
            
        case .gloomyDay:    return .white65Percent
            
        case .brownie:    return NSColor(red: 0.74, green: 0.491, blue: 0.401)
            
        case .theBlues:     return NSColor(red: 0.568, green: 0.646, blue: 0.687)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playerTrackInfoTertiaryTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white55Percent
            
        case .blackAqua:  return .white55Percent
            
        case .lava:     return .white55Percent
            
        case .whiteBlight:  return .white25Percent
            
        case .gloomyDay:    return .white55Percent
            
        case .brownie:    return NSColor(red: 0.636, green: 0.422, blue: 0.345)
            
        case .theBlues:     return NSColor(red: 0.508, green: 0.576, blue: 0.614)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playerSliderValueTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:     return .white50Percent
            
        case .whiteBlight:  return .white20Percent
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.74, green: 0.491, blue: 0.401)
            
        case .theBlues:     return NSColor(red: 0.553, green: 0.627, blue: 0.668)
            
        case .poolsideFM:   return .black
        
        }
    }
    
    var playerSliderForegroundColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .green75Percent
            
        case .blackAqua:  return .aqua
            
        case .lava:     return .lava
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.8, green: 0.329, blue: 0.293)
            
        case .theBlues:     return NSColor(red: 0.313, green: 0.548, blue: 0.756)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playerSliderForegroundGradientType: ColorSchemeGradientType {
        
        switch self {
            
        case .blackAttack:  return .darken
            
        case .blackAqua:  return .darken
            
        case .lava:     return .brighten
            
        case .whiteBlight:  return .none
            
        case .gloomyDay:    return .darken
            
        case .brownie:    return .darken
            
        case .theBlues:     return .darken
            
        case .poolsideFM:   return .none
            
        }
    }
    
    var playerSliderForegroundGradientAmount: Int {
        
        switch self {
            
        case .blackAttack:  return 70
            
        case .blackAqua:  return 60
            
        case .lava:     return 60
            
        case .whiteBlight:  return 20
            
        case .gloomyDay:    return 50
            
        case .brownie:    return 50
            
        case .theBlues:     return 40
            
        case .poolsideFM:   return 20
            
        }
    }
    
    var playerSliderBackgroundColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white20Percent
            
        case .blackAqua:  return .white20Percent
            
        case .lava:     return NSColor(red: 0.326, green: 0.326, blue: 0.326)
            
        case .whiteBlight:  return .white60Percent
            
        case .gloomyDay:    return .white8Percent
            
        case .brownie:    return NSColor.black
            
        case .theBlues:     return .white8Percent
            
        case .poolsideFM:   return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
    
    var playerSliderBackgroundGradientType: ColorSchemeGradientType {
        
        switch self {
            
        case .blackAttack:  return .none
            
        case .blackAqua:  return .none
            
        case .lava:     return .darken
            
        case .whiteBlight:  return .none
            
        case .gloomyDay:    return .none
            
        case .brownie:         return .none
            
        case .theBlues:     return .none
            
        case .poolsideFM:   return .none
            
        }
    }
    
    var playerSliderBackgroundGradientAmount: Int {
        
        switch self {
        
        case .lava:     return 36
            
        default:        return 20
            
        }
    }
    
    var playerSliderKnobColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .green75Percent
            
        case .blackAqua:  return .aqua
            
        case .lava:     return .lava
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.8, green: 0.329, blue: 0.293)
            
        case .theBlues:     return NSColor(red: 0.313, green: 0.548, blue: 0.756)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playerSliderKnobColorSameAsForeground: Bool {
        return true
    }
    
    var playerSliderLoopSegmentColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white60Percent
            
        case .blackAqua:  return .white60Percent
            
        case .lava:     return .white60Percent
            
        case .whiteBlight:  return .white40Percent
            
        case .gloomyDay:    return .white60Percent
            
        case .brownie:    return NSColor(red: 0.75, green: 0.452, blue: 0.43)
            
        case .theBlues:     return NSColor(red: 0.381, green: 0.667, blue: 0.924)
            
        case .poolsideFM:   return .white
            
        }
    }
    
    // MARK: Playlist colors ------------------------------------------------------------------------------------------------------
    
    var playlistTrackNameTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:  return .white50Percent
            
        case .whiteBlight:  return .white20Percent
            
        case .gloomyDay:    return .white55Percent
            
        case .brownie:    return NSColor(red: 0.614, green: 0.407, blue: 0.332)
            
        case .theBlues:     return NSColor(red: 0.524, green: 0.595, blue: 0.634)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playlistGroupNameTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white40Percent
            
        case .blackAqua:  return .white40Percent
            
        case .lava:  return .white40Percent
            
        case .whiteBlight:  return .white30Percent
            
        case .gloomyDay:    return .white45Percent
            
        case .brownie:    return NSColor(red: 0.519, green: 0.345, blue: 0.281)
            
        case .theBlues:     return NSColor(red: 0.473, green: 0.536, blue: 0.572)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playlistIndexDurationTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white30Percent
            
        case .blackAqua:  return .white30Percent
            
        case .lava:  return .white30Percent
            
        case .whiteBlight:  return .white45Percent
            
        case .gloomyDay:    return .white37Percent
            
        case .brownie:    return NSColor(red: 0.448, green: 0.297, blue: 0.243)
            
        case .theBlues:     return NSColor(red: 0.429, green: 0.486, blue: 0.518)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playlistTrackNameSelectedTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white80Percent
            
        case .blackAqua:  return .white80Percent
            
        case .lava:  return .white80Percent
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .white80Percent
            
        case .brownie:    return NSColor(red: 0.856, green: 0.346, blue: 0.286)
            
        case .theBlues:     return NSColor(red: 0.597, green: 0.715, blue: 0.829)
            
        case .poolsideFM:   return .white
            
        }
    }
    
    var playlistGroupNameSelectedTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white55Percent
            
        case .blackAqua:  return .white55Percent
            
        case .lava:  return .white55Percent
            
        case .whiteBlight:  return .white15Percent
            
        case .gloomyDay:    return .white55Percent
            
        case .brownie:    return NSColor(red: 0.744, green: 0.301, blue: 0.247)
            
        case .theBlues:     return NSColor(red: 0.508, green: 0.608, blue: 0.705)
            
        case .poolsideFM:   return .white
            
        }
    }
    
    var playlistIndexDurationSelectedTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:  return .white50Percent
            
        case .whiteBlight:  return .white20Percent
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.668, green: 0.271, blue: 0.221)
            
        case .theBlues:     return NSColor(red: 0.424, green: 0.508, blue: 0.59)
            
        case .poolsideFM:   return .white
            
        }
    }
    
    var playlistGroupIconColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white35Percent
            
        case .blackAqua:  return .white35Percent
            
        case .lava:  return .white35Percent
            
        case .whiteBlight:  return .white30Percent
            
        case .gloomyDay:    return .white40Percent
            
        case .brownie:    return NSColor(red: 0.5, green: 0.332, blue: 0.271)
            
        case .theBlues:     return NSColor(red: 0.37, green: 0.431, blue: 0.534)
            
        case .poolsideFM:   return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
    
    var playlistGroupDisclosureTriangleColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white60Percent
            
        case .blackAqua:  return .white60Percent
            
        case .lava:  return .white60Percent
            
        case .whiteBlight:  return .white25Percent
            
        case .gloomyDay:    return .white60Percent
            
        case .brownie:    return NSColor(red: 0.608, green: 0.403, blue: 0.329)
            
        case .theBlues:     return NSColor(red: 0.429, green: 0.5, blue: 0.618)
            
        case .poolsideFM:  return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
    
    var playlistSelectionBoxColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white15Percent
            
        case .blackAqua:  return .white15Percent
            
        case .lava:  return .black
            
        case .whiteBlight:  return .white60Percent
            
        case .gloomyDay:    return .white10Percent
            
        case .brownie:    return NSColor(red: 0.073, green: 0.047, blue: 0.038)
            
        case .theBlues:     return NSColor(red: 0.079, green: 0.139, blue: 0.192)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var playlistPlayingTrackIconColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .green75Percent
            
        case .blackAqua:  return .aqua
            
        case .lava:     return .lava
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .aqua
            
        case .brownie:    return NSColor(red: 0.856, green: 0.346, blue: 0.286)
            
        case .theBlues:     return NSColor(red: 0.313, green: 0.548, blue: 0.756)
            
        case .poolsideFM:   return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
    
    var playlistSummaryInfoColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white50Percent
            
        case .blackAqua:  return .white50Percent
            
        case .lava:     return .white50Percent
            
        case .whiteBlight:  return .white25Percent
            
        case .gloomyDay:    return .white50Percent
            
        case .brownie:    return NSColor(red: 0.622, green: 0.412, blue: 0.337)
            
        case .theBlues:     return NSColor(red: 0.477, green: 0.541, blue: 0.576)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    // MARK: Effects color scheme ------------------------------------------------------------------------------------------------------------------------------
    
    var effectsFunctionCaptionTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white45Percent
            
        case .blackAqua:  return .white45Percent
            
        case .lava:  return .white45Percent
            
        case .whiteBlight:  return .white25Percent
            
        case .gloomyDay:    return .white45Percent
            
        case .brownie:    return NSColor(red: 0.614, green: 0.407, blue: 0.333)
            
        case .theBlues:     return NSColor(red: 0.491, green: 0.557, blue: 0.593)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var effectsFunctionValueTextColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white70Percent
            
        case .blackAqua:  return .white70Percent
            
        case .lava:     return .white70Percent
            
        case .whiteBlight:  return .white10Percent
            
        case .gloomyDay:    return .white70Percent
            
        case .brownie:    return NSColor(red: 0.805, green: 0.534, blue: 0.436)
            
        case .theBlues:     return NSColor(red: 0.617, green: 0.7, blue: 0.746)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var effectsSliderBackgroundColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white15Percent
            
        case .blackAqua:  return .white15Percent
            
        case .lava:     return NSColor(red: 0.326, green: 0.326, blue: 0.326)
            
        case .whiteBlight:  return .white60Percent
            
        case .gloomyDay:    return .white25Percent
            
        case .brownie:    return NSColor(red: 0.592, green: 0.381, blue: 0.309)
            
        case .theBlues:     return NSColor(red: 0.395, green: 0.416, blue: 0.416)
            
        case .poolsideFM:   return NSColor(red: 0.671, green: 0.467, blue: 0.475)
            
        }
    }
  
    var effectsSliderBackgroundGradientType: ColorSchemeGradientType {
        
        switch self {
            
        case .blackAttack:  return .brighten
            
        case .blackAqua:  return .brighten
            
        case .lava:  return .darken
            
        case .whiteBlight:  return .none
            
        case .gloomyDay:    return .brighten
            
        case .brownie:    return .darken
            
        case .theBlues:     return .darken
            
        case .poolsideFM:   return .none
            
        }
    }
    
    var effectsSliderBackgroundGradientAmount: Int {
        
        switch self {
            
        case .blackAttack:  return 20
            
        case .blackAqua:  return 20
            
        case .lava:     return 36
            
        case .whiteBlight:  return 0
            
        case .gloomyDay:    return 15
            
        case .brownie:    return 50
            
        case .theBlues:     return 40
            
        case .poolsideFM:   return 0
            
        }
    }
    
    var effectsSliderKnobColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .green75Percent
            
        case .blackAqua:  return .aqua
            
        case .lava:     return .lava
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .aqua
            
        case .brownie:    return NSColor(red: 0.8, green: 0.329, blue: 0.293)
            
        case .theBlues:     return NSColor(red: 0, green: 0.568, blue: 0.756)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var effectsSliderKnobColorSameAsForeground: Bool {
        return true
    }
    
    var effectsSliderTickColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .black
            
        case .blackAqua:  return .black
            
        case .lava:     return .black
            
        case .whiteBlight:  return .white
            
        case .gloomyDay:    return .black
            
        case .brownie:         return .black
            
        case .theBlues:     return .black
            
        case .poolsideFM:   return .white
            
        }
    }
    
    var effectsActiveUnitStateColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .green75Percent
            
        case .blackAqua:  return .aqua
            
        case .lava:     return .lava
            
        case .whiteBlight:  return .black
            
        case .gloomyDay:    return .aqua
            
        case .brownie:    return NSColor(red: 0.8, green: 0.329, blue: 0.293)
            
        case .theBlues:     return NSColor(red: 0, green: 0.568, blue: 0.756)
            
        case .poolsideFM:   return .black
            
        }
    }
    
    var effectsBypassedUnitStateColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return .white60Percent
            
        case .blackAqua:  return .white60Percent
            
        case .lava:  return .white60Percent
            
        case .whiteBlight:  return .white40Percent
            
        case .gloomyDay:    return .white55Percent
            
        case .brownie:    return NSColor(red: 0.668, green: 0.507, blue: 0.436)
            
        case .theBlues:     return NSColor(red: 0.446, green: 0.505, blue: 0.539)
            
        case .poolsideFM:   return .white50Percent
            
        }
    }
    
    var effectsSuppressedUnitStateColor: NSColor {
        
        switch self {
            
        case .blackAttack:  return NSColor(red: 0.76, green: 0.69, blue: 0)
            
        case .blackAqua:  return NSColor(red: 0, green: 0.31, blue: 0.5)
            
        case .lava:  return NSColor(red: 0.5, green: 0.204, blue: 0.107)
        
        case .whiteBlight:  return .white20Percent
            
        case .gloomyDay:    return NSColor(red: 0, green: 0.4, blue: 0.65)
            
        case .brownie:    return NSColor(red: 0.599, green: 0.245, blue: 0.217)
            
        case .theBlues:     return NSColor(red: 0, green: 0.4, blue: 0.65)
            
        case .poolsideFM:   return .white25Percent
            
        }
    }
    
    var effectsSliderForegroundGradientType: ColorSchemeGradientType {
        
        switch self {
            
        case .blackAttack:  return .darken
            
        case .blackAqua:    return .darken
            
        case .lava:         return .brighten
            
        case .whiteBlight:  return .brighten
            
        case .gloomyDay:    return .darken
            
        case .brownie:      return .darken
            
        case .theBlues:     return .darken
            
        case .poolsideFM:   return .none
            
        }
    }
    
    var effectsSliderForegroundGradientAmount: Int {
        
        switch self {
            
        case .blackAttack:  return 60
            
        case .blackAqua:    return 60
            
        case .lava:         return 60
            
        case .whiteBlight:  return 30
            
        case .gloomyDay:    return 60
            
        case .brownie:      return 50
        
        case .theBlues:     return 45
            
        case .poolsideFM:   return 0
            
        }
    }
}
