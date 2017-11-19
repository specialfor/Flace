//
//  LocationService.swift
//  Nynja
//
//  Created by Anton Makarov on 04.07.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func locationUpdated(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager!
    
    static let sharedInstance: LocationService = {
        let service = LocationService()
        
        service.locationManager = CLLocationManager()
        service.locationManager.delegate = service
        service.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        service.locationManager.requestWhenInUseAuthorization()
        service.locationManager.startUpdatingLocation()
        
        return service
    }()
    
    var currentLocation: CLLocation?
    
    weak var delegate: LocationServiceDelegate?
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        currentLocation = location
        delegate?.locationUpdated(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: nothing
    }
    
}
