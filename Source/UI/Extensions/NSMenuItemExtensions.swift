//
//  NSMenuItemExtensions.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

protocol MenuItemMappable {
    
    var name: String {get}
    
    var representedObject: Any? {get}
}

extension MenuItemMappable {
    
    var representedObject: Any? {nil}
}

extension NSMenu {
    
    func addItem(withTitle title: String) {
        addItem(withTitle: title, action: nil, keyEquivalent: "")
    }
    
    func recreateMenu(insertingItemsAt index: Int, withTitles titles: [String],
                      action: Selector? = nil, target: AnyObject? = nil,
                      indentationLevel: Int? = nil) {
        
        // Remove all user-defined scheme items (i.e. all items before the first separator)
        while index < items.count, let item = item(at: index), !item.isSeparatorItem {
            removeItem(at: index)
        }
        
        // Recreate the user-defined items
        titles.forEach {

            let item: NSMenuItem = NSMenuItem(title: $0, action: action, keyEquivalent: "")
            item.target = target
            
            if let level = indentationLevel {
                item.indentationLevel = level
            }

            insertItem(item, at: index)
        }
    }
    
    func recreateMenu<T: MenuItemMappable>(insertingItemsAt index: Int, fromItems mappableItems: [T],
                                             action: Selector? = nil, target: AnyObject? = nil,
                                             indentationLevel: Int? = nil) {
        
        recreateMenu(insertingItemsAt: index, withTitles: mappableItems.map {$0.name},
                     action: action, target: target, indentationLevel: indentationLevel)
    }
}

extension NSPopUpButton {
    
    func recreateMenu<T: MenuItemMappable>(insertingItemsAt index: Int, fromItems mappableItems: [T],
                                             indentationLevel: Int? = nil) {
        
        menu?.recreateMenu(insertingItemsAt: index, fromItems: mappableItems,
                           action: action, target: target,
                           indentationLevel: indentationLevel)
    }
    
    func deselect() {
        selectItem(at: -1)
    }
}

extension NSMenuItem {
    
    convenience init(title: String) {
        self.init(title: title, action: nil, keyEquivalent: "")
    }
    
    convenience init(title: String, action: Selector) {
        self.init(title: title, action: action, keyEquivalent: "")
    }
    
    convenience init(view: NSView) {
        
        self.init(title: "", action: nil, keyEquivalent: "")
        self.view = view
    }
    
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
        state == .on
    }
    
    @objc var isOff: Bool {
        state == .off
    }
    
    @objc func toggle() {
        isOn ? off() : on()
    }
    
    var isShown: Bool {
        return !isHidden
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hideIf(_ condition: Bool) {
        condition ? hide() : show()
    }
    
    func showIf(_ condition: Bool) {
        condition ? show() : hide()
    }
    
    var isDisabled: Bool {
        return !isEnabled
    }
    
    func enable() {
        self.enableIf(true)
    }
    
    func disable() {
        self.enableIf(false)
    }
    
    func enableIf(_ condition: Bool) {
        self.isEnabled = condition
    }
    
    func disableIf(_ condition: Bool) {
        self.isEnabled = !condition
    }
    
    // Creates a menu item that serves only to describe other items in the menu. The item will have no action.
    static func createDescriptor(title: String) -> NSMenuItem {
        
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        item.disable()  // Descriptor items cannot be clicked
        return item
    }
}

