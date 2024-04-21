//
//  GeneralColorSchemePersistentState.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// Persistent state for the general component of a single color scheme.
///
/// - SeeAlso: `GeneralColorScheme`
///
struct GeneralColorSchemePersistentState: Codable {
    
    let appLogoColor: ColorPersistentState?
    let backgroundColor: ColorPersistentState?
    
    let functionButtonColor: ColorPersistentState?
    let textButtonMenuColor: ColorPersistentState?
    let toggleButtonOffStateColor: ColorPersistentState?
    let selectedTabButtonColor: ColorPersistentState?
    
    let mainCaptionTextColor: ColorPersistentState?
    let tabButtonTextColor: ColorPersistentState?
    let selectedTabButtonTextColor: ColorPersistentState?
    let buttonMenuTextColor: ColorPersistentState?
    
    init(_ scheme: GeneralColorScheme) {
        
        self.appLogoColor = ColorPersistentState(color: scheme.appLogoColor)
        self.backgroundColor = ColorPersistentState(color: scheme.backgroundColor)
        
        self.functionButtonColor = ColorPersistentState(color: scheme.functionButtonColor)
        self.textButtonMenuColor = ColorPersistentState(color: scheme.textButtonMenuColor)
        self.toggleButtonOffStateColor = ColorPersistentState(color: scheme.toggleButtonOffStateColor)
        self.selectedTabButtonColor = ColorPersistentState(color: scheme.selectedTabButtonColor)
        
        self.mainCaptionTextColor = ColorPersistentState(color: scheme.mainCaptionTextColor)
        self.tabButtonTextColor = ColorPersistentState(color: scheme.tabButtonTextColor)
        self.selectedTabButtonTextColor = ColorPersistentState(color: scheme.selectedTabButtonTextColor)
        self.buttonMenuTextColor = ColorPersistentState(color: scheme.buttonMenuTextColor)
    }
}
