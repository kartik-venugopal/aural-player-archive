//
//  FontSchemeChangeContext.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

/*
    An object that temporarily holds font settings used when applying a new customized font scheme to the app. It is used by the font scheme customization dialog when the user makes changes and clicks "Apply changes".
 */
class FontSchemeChangeContext {
    
    var textFontName: String = standardFontName
    var headingFontName: String = standardCaptionFontName
}
