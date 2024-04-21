//
//  ModalDialogButtonCells.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
/*
    Customizes the look n feel of buttons on modal dialogs
 */

import Cocoa

// Base class for all modal dialog button cells
class ModalDialogButtonCell: NSButtonCell {
    
    var cellInsetX: CGFloat {0}
    var cellInsetY: CGFloat {0}
    
    var backgroundFillGradient: NSGradient {.modalDialogButtonGradient}
    var backgroundFillGradient_disabled: NSGradient {.modalDialogButtonGradient_disabled}
    var borderRadius: CGFloat {2}
    
    var textColor: NSColor {.modalDialogButtonTextColor}
    var textColor_disabled: NSColor {.modalDialogButtonTextColor_disabled}
    
    var textFont: NSFont {.modalDialogButtonFont}
    
    var yOffset: CGFloat {0}
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        
        // Background
        let drawRect = cellFrame.insetBy(dx: cellInsetX, dy: cellInsetY)
        let gradient = isEnabled ? backgroundFillGradient : backgroundFillGradient_disabled
        NSBezierPath.fillRoundedRect(drawRect, radius: borderRadius, withGradient: gradient, angle: -.verticalGradientDegrees)
        
        // Title
        title.drawCentered(in: drawRect, withFont: textFont, andColor: isEnabled ? textColor : textColor_disabled, yOffset: yOffset)
    }
}

// Cell for all response buttons (Save/Cancel, etc)
class ModalDialogResponseButtonCell: ModalDialogButtonCell {
    
    override var cellInsetX: CGFloat {1}
    override var cellInsetY: CGFloat {0}
    override var yOffset: CGFloat {-2}
    
    override var borderRadius: CGFloat {2.5}
}

class StringInputPopoverResponseButtonCell: ModalDialogResponseButtonCell {
    override var textFont: NSFont {.stringInputPopoverFont}
}

// Cell for all response buttons (Save/Cancel, etc)
class ModalDialogControlButtonCell: ModalDialogButtonCell {
    
    override var cellInsetX: CGFloat {1}
    override var cellInsetY: CGFloat {0}
    
    override var textFont: NSFont {.modalDialogControlButtonFont}
}

// Browse button in Playlist preferences
class ModalDialogSmallControlButtonCell: ModalDialogButtonCell {
    
    override var cellInsetX: CGFloat {1}
    override var cellInsetY: CGFloat {0}
    
    override var textFont: NSFont {standardFontSet.mainFont(size: 10)}
}

// Cell for search results navigation buttons (next/previous)
class ColoredNavigationButtonCell: ModalDialogButtonCell {
    
    override var cellInsetX: CGFloat {1}
    override var cellInsetY: CGFloat {1}
    
    override var borderRadius: CGFloat {3}
    
    override var textColor: NSColor {.modalDialogNavButtonTextColor}
    override var textFont: NSFont {.modalDialogNavButtonFont}
}

class ColorAwareButtonCell: ModalDialogButtonCell {
    
    override var textColor: NSColor {Colors.buttonMenuTextColor}
    override var textColor_disabled: NSColor {Colors.buttonMenuTextColor}
    
    override var backgroundFillGradient: NSGradient {Colors.textButtonMenuGradient}
    override var backgroundFillGradient_disabled: NSGradient {Colors.textButtonMenuGradient}
}
