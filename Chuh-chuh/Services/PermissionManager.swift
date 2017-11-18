//
//  PermissionManager.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 9/5/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation

import Photos
import CoreLocation

typealias PermissionCompletion = (AuthorizationStatus) -> Void

enum AuthorizationStatus {
    case authorized
    case notAuthorized
}

enum LocationUsage {
    case whenInUse
    case always
}

class PermissionManager: NSObject {
    
    fileprivate lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        return locationManager
    }()

    fileprivate var locationCompletion: PermissionCompletion?
    
    fileprivate var permissionManager: PermissionManager?
    
    var isMicrophoneGranted: Bool {
        return AVAudioSession.sharedInstance().recordPermission() == AVAudioSessionRecordPermission.granted
    }
    
    func requestCameraPermission(with completion:PermissionCompletion?) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            self.p_requestCameraPermission(with: completion)
        } else {
            DispatchQueue.main.async {
                self.showNoCameraAlert()
                completion?(.notAuthorized)
            }
        }
    }
    
    func requestGaleryPermission(with completion:PermissionCompletion?) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .denied, .restricted:
            DispatchQueue.main.async {
                AlertManager.sharedInstance.showAlertAllowPermission(resourceName: "gallery")
                completion?(.notAuthorized)
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    let authoriationStatus: AuthorizationStatus = status == .authorized ? .authorized : .notAuthorized
                    completion?(authoriationStatus)
                }
            }
        case .authorized:
            DispatchQueue.main.async {
                completion?(.authorized)
            }
        }
    }
    
    func requestLocationPermission(with locationUsage: LocationUsage, completion: @escaping PermissionCompletion) {
        self.permissionManager = self
        self.locationCompletion = completion
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .denied, .restricted:
            DispatchQueue.main.async {
                AlertManager.sharedInstance.showAlertAllowPermission(resourceName: "location")
                self.callLocationCompletion(with: .notAuthorized)
            }
        case .notDetermined:
            self.requestLocationPermision(with: locationUsage)
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                self.callLocationCompletion(with: .authorized)
            }
        }
    }
    
    func requestMicrophonePermission(with completion: PermissionCompletion?) {
        let session = AVAudioSession.sharedInstance()
        
        let status = session.recordPermission()
        
        switch status {
        case AVAudioSessionRecordPermission.granted:
            DispatchQueue.main.async {
                completion?(.authorized)
            }
        case AVAudioSessionRecordPermission.denied:
            DispatchQueue.main.async {
                AlertManager.sharedInstance.showAlertAllowPermission(resourceName: "microphone")
                completion?(.notAuthorized)
            }
        case AVAudioSessionRecordPermission.undetermined:
            session.requestRecordPermission { (result) in
                DispatchQueue.main.async {
                    let authorizationStatis: AuthorizationStatus = result ? .authorized : .notAuthorized
                    completion?(authorizationStatis)
                }
            }
        }
    }
    
}

// MARK: Private methods
fileprivate extension PermissionManager {
    
    func p_requestCameraPermission(with completion:PermissionCompletion?) {
        let mediaType = AVMediaType.video
        
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        
        switch status {
        case .denied, .restricted:
            DispatchQueue.main.async {
                AlertManager.sharedInstance.showAlertAllowPermission(resourceName: "camera")
                completion?(.notAuthorized)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { (result) in
                DispatchQueue.main.async {
                    let status: AuthorizationStatus = result ? .authorized : .notAuthorized
                    completion?(status)
                }
            }
        case .authorized:
            DispatchQueue.main.async {
                completion?(.authorized)
            }
        }
    }
    
    func showNoCameraAlert() {
        AlertManager.sharedInstance.showAlertOk(title: "No camera", message: "Sorry, this device has no camera.", completion: nil)
    }
    
    func requestLocationPermision(with locationUsage: LocationUsage) {
        switch locationUsage {
        case .always:
            self.locationManager.requestAlwaysAuthorization()
        case .whenInUse:
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func callLocationCompletion(with status: AuthorizationStatus) {
        self.locationCompletion?(status)
        self.locationCompletion = nil
        self.permissionManager = nil
    }
    
}

// MARK: CLLocationManagerDelegate
extension PermissionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            DispatchQueue.main.async {
                let authorizationStatus: AuthorizationStatus = status == .authorizedWhenInUse || status == .authorizedAlways ? .authorized : .notAuthorized
                
                self.callLocationCompletion(with: authorizationStatus)
            }
        }
    }
    
}
