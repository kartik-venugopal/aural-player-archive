//
//  DeviceList.swift
//  Aural
//
//  Copyright © 2021 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import AudioToolbox

///
/// Encapsulates a collection of audio output hardware devices available on the local system, and provides
/// functions for convenient searching of devices.
///
class InternalDeviceList {
    
    private let systemAudioObject: AudioObjectID = .systemAudioObject
    
    // id -> Device
    private var knownDevices: [AudioDeviceID: AudioDevice] = [:]
    
    private(set) var devices: [AudioDevice] = []
    
    // id -> Device
    private var devicesMap: [AudioDeviceID: AudioDevice] = [:]
    
    private var lastRebuildTime: Double = 0
    private static let minRebuildTimeSeparation: Double = 0.1
    
    // Used to ensure that simultaneous reads/writes cannot occur.
    private let semaphore = DispatchSemaphore(value: 1)
    
    init() {
        
        rebuildList()
        
        // Devices list change listener
        systemAudioObject.registerDevicesPropertyListener({self.rebuildList()}, queue: DispatchQueue.global(qos: .utility))
    }
    
    private func rebuildList() {
     
        semaphore.wait()
        defer {semaphore.signal()}
        
        // Determine when the list was last rebuilt. If the time interval between
        // now and that timestamp is less than a threshold, return without doing anything.
        // This is necessary to prevent repeated (redundant) rebuilding of the list in response
        // to duplicate notifications.
        let now = CFAbsoluteTimeGetCurrent()
        if (now - self.lastRebuildTime) < Self.minRebuildTimeSeparation {return}
        
        let deviceIds: [AudioDeviceID] = systemAudioObject.devices
        
        self.lastRebuildTime = now
        
        devices.removeAll()
        devicesMap.removeAll()
        
        for deviceId in deviceIds {
            
            if let device = knownDevices[deviceId] ?? AudioDevice(deviceId: deviceId) {
                
                devices.append(device)
                devicesMap[deviceId] = device
                
                if knownDevices[deviceId] == nil {
                    knownDevices[deviceId] = device
                }
            }
        }
        
        Messenger.publish(.deviceManager_deviceListUpdated)
    }
    
    func deviceById(_ id: AudioDeviceID) -> AudioDevice? {

        semaphore.wait()
        defer {semaphore.signal()}
        
        return devicesMap[id]
    }
}
