//
//  UpdatesDialogController.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

class UpdatesDialogController: NSWindowController, ModalComponentProtocol {
    
    override var windowNibName: String? {"UpdatesDialog"}

    @IBOutlet weak var lblNoUpdates: NSTextField!
    @IBOutlet weak var lblUpdateAvailable: NSTextField!
    @IBOutlet weak var lblError: NSTextField!
    
    @IBOutlet weak var btnOK: NSButton!
    @IBOutlet weak var btnGetLatestVersion: NSButton!
    
    @IBOutlet weak var spinner: NSProgressIndicator!
    
    private lazy var workspace: NSWorkspace = NSWorkspace.shared
    private let latestReleaseURL: URL = URL(string: "https://github.com/maculateConception/aural-player/releases/latest")!
    
    private lazy var windowLayoutsManager: WindowLayoutsManager = objectGraph.windowLayoutsManager
    
    override func showWindow(_ sender: Any?) {
        
        forceLoadingOfWindow()
        
        spinner?.startAnimation(self)
        spinner?.show()
        
        [lblNoUpdates, lblUpdateAvailable, lblError].forEach {$0?.hide()}
        
        theWindow.showCentered(relativeTo: windowLayoutsManager.mainWindow)
    }
    
    var isModal: Bool {self.window?.isVisible ?? false}
    
    @IBAction func okAction(_ sender: Any) {
        window?.close()
    }
    
    @IBAction func getLatestVersionAction(_ sender: Any) {
        
        window?.close()
        workspace.open(latestReleaseURL)
    }
    
    func noUpdatesAvailable() {
        
        spinner.stopAnimation(self)
        spinner.hide()
        
        lblNoUpdates.show()
        
        lblUpdateAvailable.hide()
        lblError.hide()
        btnGetLatestVersion.hide()
    }
    
    func updateIsAvailable(version: AppVersion) {
        
        spinner.stopAnimation(self)
        spinner.hide()
        
        lblNoUpdates.hide()
        lblError.hide()
        
        lblUpdateAvailable.stringValue = "Update: Version \(version.versionString) is available !"
        lblUpdateAvailable.show()
        btnGetLatestVersion.show()
    }
    
    func showError() {
        
        spinner.stopAnimation(self)
        spinner.hide()
        
        lblError.show()
        
        lblNoUpdates.hide()
        lblUpdateAvailable.hide()
        btnGetLatestVersion.hide()
    }
}
