//
//  NSButtonExtensions.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

extension NSButton {
    
    @objc func off() {
        self.state = .off
    }
    
    @objc func on() {
        self.state = .on
    }
    
    @objc func onIf(_ condition: Bool) {
        condition ? on() : off()
    }
    
    @objc var isOn: Bool {
        return self.state == .on
    }
    
    @objc var isOff: Bool {
        return self.state == .off
    }
    
    @objc func toggle() {
        isOn ? off() : on()
    }
}

extension NSButtonCell {

    @objc func off() {
        self.state = .off
    }

    @objc func on() {
        self.state = .on
    }

    @objc func onIf(_ condition: Bool) {
        condition ? on() : off()
    }

    @objc var isOn: Bool {
        return self.state == .on
    }

    @objc var isOff: Bool {
        return self.state == .off
    }

    @objc func toggle() {
        isOn ? off() : on()
    }
}
