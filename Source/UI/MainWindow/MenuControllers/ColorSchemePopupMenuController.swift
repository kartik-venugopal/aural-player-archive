//
//  ColorSchemePopupMenuController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    Controller for the popup menu that lists the available color schemes and opens the color scheme editor panel.
 */
class ColorSchemePopupMenuController: GenericPresetPopupMenuController {
    
    private lazy var customizationDialogController: ColorSchemesWindowController = ColorSchemesWindowController.instance
    private lazy var managerWindowController: PresetsManagerWindowController = PresetsManagerWindowController.instance
    
    private let colorSchemesManager: ColorSchemesManager = objectGraph.colorSchemesManager
    
    override var descriptionOfPreset: String {"color scheme"}
    override var descriptionOfPreset_plural: String {"color schemes"}
    
    override var userDefinedPresets: [UserManagedObject] {colorSchemesManager.userDefinedObjects}
    override var numberOfUserDefinedPresets: Int {colorSchemesManager.numberOfUserDefinedObjects}
    
    override func presetExists(named name: String) -> Bool {
        colorSchemesManager.objectExists(named: name)
    }
    
    // Receives a new color scheme name and saves the new scheme.
    override func addPreset(named name: String) {
        
        // Copy the current system scheme into the new scheme, and name it with the user's given scheme name
        let newScheme: ColorScheme = ColorScheme(name, false, colorSchemesManager.systemScheme)
        colorSchemesManager.addObject(newScheme)
    }
    
    override func applyPreset(named name: String) {
        colorSchemesManager.applyScheme(named: name)
    }
    
    @IBAction func customizeSchemeAction(_ sender: NSMenuItem) {
        _ = customizationDialogController.showDialog()
    }
    
    @IBAction func manageSchemesAction(_ sender: NSMenuItem) {
        managerWindowController.showColorSchemesManager()
    }
    
    deinit {
        ColorSchemesWindowController.destroy()
    }
}
