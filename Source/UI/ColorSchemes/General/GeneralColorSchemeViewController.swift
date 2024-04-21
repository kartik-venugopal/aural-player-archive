//
//  GeneralColorSchemeViewController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

/*
    Controller for the view that allows the user to edit general color scheme elements.
 */
class GeneralColorSchemeViewController: ColorSchemeViewController {
    
    @IBOutlet weak var appLogoColorPicker: AuralColorPicker!
    @IBOutlet weak var backgroundColorPicker: AuralColorPicker!
    
    @IBOutlet weak var functionButtonColorPicker: AuralColorPicker!
    @IBOutlet weak var textButtonMenuColorPicker: AuralColorPicker!
    @IBOutlet weak var toggleButtonOffStateColorPicker: AuralColorPicker!
    @IBOutlet weak var selectedTabButtonColorPicker: AuralColorPicker!
    
    @IBOutlet weak var mainCaptionTextColorPicker: AuralColorPicker!
    @IBOutlet weak var tabButtonTextColorPicker: AuralColorPicker!
    @IBOutlet weak var selectedTabButtonTextColorPicker: AuralColorPicker!
    @IBOutlet weak var buttonMenuTextColorPicker: AuralColorPicker!
    
    private let colorSchemesManager: ColorSchemesManager = objectGraph.colorSchemesManager
    
    private lazy var messenger = Messenger(for: self)
    
    override var nibName: NSNib.Name? {"GeneralColorScheme"}
    
    private var generalScheme: GeneralColorScheme {
        colorSchemesManager.systemScheme.general
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Map control tags to their corresponding undo/redo actions
        
        actionsMap[appLogoColorPicker.tag] = self.changeAppLogoColor
        actionsMap[backgroundColorPicker.tag] = self.changeBackgroundColor
        actionsMap[functionButtonColorPicker.tag] = self.changeFunctionButtonColor
        actionsMap[textButtonMenuColorPicker.tag] = self.changeTextButtonMenuColor
        actionsMap[toggleButtonOffStateColorPicker.tag] = self.changeToggleButtonOffStateColor
        actionsMap[selectedTabButtonColorPicker.tag] = self.changeSelectedTabButtonColor
        actionsMap[mainCaptionTextColorPicker.tag] = self.changeMainCaptionTextColor
        actionsMap[tabButtonTextColorPicker.tag] = self.changeTabButtonTextColor
        actionsMap[selectedTabButtonTextColorPicker.tag] = self.changeSelectedTabButtonTextColor
        actionsMap[buttonMenuTextColorPicker.tag] = self.changeButtonMenuTextColor
    }
    
    override func resetFields(_ scheme: ColorScheme, _ history: ColorSchemeHistory, _ clipboard: ColorClipboard) {
        
        super.resetFields(scheme, history, clipboard)
        
        // Update the UI to reflect the current system color scheme
        
        appLogoColorPicker.color = scheme.general.appLogoColor
        backgroundColorPicker.color = scheme.general.backgroundColor
        
        functionButtonColorPicker.color = scheme.general.functionButtonColor
        textButtonMenuColorPicker.color = scheme.general.textButtonMenuColor
        toggleButtonOffStateColorPicker.color = scheme.general.toggleButtonOffStateColor
        selectedTabButtonColorPicker.color = scheme.general.selectedTabButtonColor
        
        mainCaptionTextColorPicker.color = scheme.general.mainCaptionTextColor
        tabButtonTextColorPicker.color = scheme.general.tabButtonTextColor
        selectedTabButtonTextColorPicker.color = scheme.general.selectedTabButtonTextColor
        buttonMenuTextColorPicker.color = scheme.general.buttonMenuTextColor
    }
    
    @IBAction func appLogoColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: appLogoColorPicker.tag, undoValue: generalScheme.appLogoColor,
                                             redoValue: appLogoColorPicker.color, changeType: .changeColor))
        changeAppLogoColor()
    }
    
    private func changeAppLogoColor() {
        
        generalScheme.appLogoColor = appLogoColorPicker.color
        messenger.publish(.changeAppLogoColor, payload: appLogoColorPicker.color)
    }
    
    @IBAction func backgroundColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: backgroundColorPicker.tag, undoValue: generalScheme.backgroundColor,
                                             redoValue: backgroundColorPicker.color, changeType: .changeColor))
        changeBackgroundColor()
    }
    
    private func changeBackgroundColor() {
        
        generalScheme.backgroundColor = backgroundColorPicker.color
        messenger.publish(.changeBackgroundColor, payload: backgroundColorPicker.color)
    }
    
    @IBAction func functionButtonColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: functionButtonColorPicker.tag, undoValue: generalScheme.functionButtonColor,
                                             redoValue: functionButtonColorPicker.color, changeType: .changeColor))
        changeFunctionButtonColor()
    }
    
    private func changeFunctionButtonColor() {
        
        generalScheme.functionButtonColor = functionButtonColorPicker.color
        messenger.publish(.changeFunctionButtonColor, payload: functionButtonColorPicker.color)
    }
    
    @IBAction func textButtonMenuColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: textButtonMenuColorPicker.tag, undoValue: generalScheme.textButtonMenuColor,
                                             redoValue: textButtonMenuColorPicker.color, changeType: .changeColor))
        changeTextButtonMenuColor()
    }
    
    private func changeTextButtonMenuColor() {
        
        generalScheme.textButtonMenuColor = textButtonMenuColorPicker.color
        messenger.publish(.changeTextButtonMenuColor, payload: textButtonMenuColorPicker.color)
    }
    
    @IBAction func toggleButtonOffStateColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: toggleButtonOffStateColorPicker.tag, undoValue: generalScheme.toggleButtonOffStateColor,
                                             redoValue: toggleButtonOffStateColorPicker.color, changeType: .changeColor))
        changeToggleButtonOffStateColor()
    }
    
    private func changeToggleButtonOffStateColor() {
        
        generalScheme.toggleButtonOffStateColor = toggleButtonOffStateColorPicker.color
        messenger.publish(.changeToggleButtonOffStateColor, payload: toggleButtonOffStateColorPicker.color)
    }
    
    @IBAction func selectedTabButtonColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: selectedTabButtonColorPicker.tag, undoValue: generalScheme.selectedTabButtonColor,
                                             redoValue: selectedTabButtonColorPicker.color, changeType: .changeColor))
        changeSelectedTabButtonColor()
    }
    
    private func changeSelectedTabButtonColor() {
        
        generalScheme.selectedTabButtonColor = selectedTabButtonColorPicker.color
        messenger.publish(.changeSelectedTabButtonColor, payload: selectedTabButtonColorPicker.color)
    }
    
    @IBAction func mainCaptionTextColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: mainCaptionTextColorPicker.tag, undoValue: generalScheme.mainCaptionTextColor,
                                             redoValue: mainCaptionTextColorPicker.color, changeType: .changeColor))
        changeMainCaptionTextColor()
    }
    
    private func changeMainCaptionTextColor() {
        
        generalScheme.mainCaptionTextColor = mainCaptionTextColorPicker.color
        messenger.publish(.changeMainCaptionTextColor, payload: mainCaptionTextColorPicker.color)
    }
    
    @IBAction func tabButtonTextColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: tabButtonTextColorPicker.tag, undoValue: generalScheme.tabButtonTextColor,
                                             redoValue: tabButtonTextColorPicker.color, changeType: .changeColor))
        changeTabButtonTextColor()
    }
    
    private func changeTabButtonTextColor()	{
        
        generalScheme.tabButtonTextColor = tabButtonTextColorPicker.color
        messenger.publish(.changeTabButtonTextColor, payload: tabButtonTextColorPicker.color)
    }
    
    @IBAction func selectedTabButtonTextColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: selectedTabButtonTextColorPicker.tag, undoValue: generalScheme.selectedTabButtonTextColor,
                                             redoValue: selectedTabButtonTextColorPicker.color, changeType: .changeColor))
        changeSelectedTabButtonTextColor()
    }
    
    private func changeSelectedTabButtonTextColor()    {
        
        generalScheme.selectedTabButtonTextColor = selectedTabButtonTextColorPicker.color
        messenger.publish(.changeSelectedTabButtonTextColor, payload: selectedTabButtonTextColorPicker.color)
    }
    
    @IBAction func buttonMenuTextColorAction(_ sender: Any) {
        
        history.noteChange(ColorSchemeChange(tag: buttonMenuTextColorPicker.tag, undoValue: generalScheme.buttonMenuTextColor,
                                             redoValue: buttonMenuTextColorPicker.color, changeType: .changeColor))
        changeButtonMenuTextColor()
    }
    
    private func changeButtonMenuTextColor() {
        
        generalScheme.buttonMenuTextColor = buttonMenuTextColorPicker.color
        messenger.publish(.changeButtonMenuTextColor, payload: buttonMenuTextColorPicker.color)
    }
}
