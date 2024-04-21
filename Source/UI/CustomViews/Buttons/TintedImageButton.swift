//
//  TintedImageButton.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    A special image button to which a tint can be applied, to conform to the current system color scheme.
 */
@IBDesignable
class TintedImageButton: NSButton, Tintable {
    
    // A base image that is used as an image template.
    @IBInspectable var baseImage: NSImage? {
        
        // Re-tint the image whenever the base image is updated.
        didSet {
            reTint()
        }
    }
 
    // A function that produces a color used to tint the base image.
    var tintFunction: () -> NSColor = {Colors.functionButtonColor} {
        
        // Re-tint the image whenever the function is updated.
        didSet {
            reTint()
        }
    }
    
    // Reapplies the tint (eg. when the tint color has changed or the base image has changed).
    func reTint() {
        self.image = self.baseImage?.filledWithColor(tintFunction())
    }
}

// A contract for any object to which a tint can be applied (and re-applied). This is used by various UI elements to conform to the system color scheme.
protocol Tintable {
    
    func reTint()
}

typealias TintFunction = () -> NSColor
