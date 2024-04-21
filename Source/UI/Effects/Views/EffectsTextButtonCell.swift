//
//  EffectsTextButtonCell.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  
import Cocoa

class EffectsTextButtonCell: ColorAwareButtonCell {
    
    override var textFont: NSFont {Fonts.Effects.unitFunctionFont}
    override var yOffset: CGFloat {-1}
}
