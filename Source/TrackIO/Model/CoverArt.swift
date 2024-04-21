//
//  CoverArt.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

///
/// Encapsulates album art and metadata about the image.
///
struct CoverArt {
    
    let image: NSImage
    let metadata: ImageMetadata?
    
    init?(imageFile: URL) {
        
        guard let image = NSImage(contentsOfFile: imageFile.path) else {return nil}
        self.image = image
        
        do {

            // Read the image file for image metadata.
            let imgData: Data = try Data(contentsOf: imageFile)
            self.metadata = ParserUtils.getImageMetadata(imgData as NSData)
            
        } catch {
            NSLog("Warning - Unable to read data from the image file: \(imageFile.path)")
            self.metadata = nil
        }
    }
    
    init?(imageData: Data) {
        
        guard let image = NSImage(data: imageData) else {return nil}
        
        self.image = image
        self.metadata = ParserUtils.getImageMetadata(imageData as NSData)
    }
}

///
/// Metadata about an image (cover art).
///
struct ImageMetadata {
    
    // e.g. JPEG/PNG
    var type: String? = nil
    
    // e.g. 1680x1050
    var dimensions: NSSize? = nil
    
    // e.g. 72x72 DPI
    var resolution: NSSize? = nil
    
    // e.g. RGB
    var colorSpace: String? = nil
    
    // e.g. "sRGB IEC61966-2.1"
    var colorProfile: String? = nil
    
    // e.g. 8 bit
    var bitDepth: Int? = nil

    // True for transparent images like PNGs
    var hasAlpha: Bool? = nil
}
