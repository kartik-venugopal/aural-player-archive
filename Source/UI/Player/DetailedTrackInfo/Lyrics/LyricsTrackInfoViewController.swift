//
//  LyricsTrackInfoViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//  
import Cocoa

class LyricsTrackInfoViewController: NSViewController, TrackInfoViewProtocol {
    
    override var nibName: String? {"LyricsTrackInfo"}
    
    @IBOutlet weak var textView: NSTextView! {
        
        didSet {
            
            textView.font = standardFontSet.mainFont(size: 13)
            textView.alignment = .center
            textView.backgroundColor = .popoverBackgroundColor
            textView.textColor = .boxTextColor
            textView.enclosingScrollView?.contentInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            textView.enclosingScrollView?.scrollerInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: -9)
        }
    }
    
    private let noLyricsText: String = "< No lyrics available for this track >"
    
    // Called each time the popover is shown ... refreshes the data in the table view depending on which track is currently playing
    func refresh(forTrack track: Track) {
        textView?.string = track.lyrics ?? noLyricsText
    }
    
    var jsonObject: AnyObject? {
        textView.string as NSString
    }
    
    func writeHTML(forTrack track: Track, to writer: HTMLWriter) {
        
        writer.addHeading("Lyrics:", 3, true)
        
        let lyrics = HTMLText(text: textView.string, underlined: false, bold: false, italic: false, width: nil)
        writer.addParagraph(lyrics)
    }
}
