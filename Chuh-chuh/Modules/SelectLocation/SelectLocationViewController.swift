//
//  SelectLocationViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import MapKit

class SelectLocationViewController: ViewController {
    
    var location: Location?
    
    // MARK: Views
    lazy var mapView: MapView = {
        let mView = MapView()
        
        self.view.addSubview(mView)
        mView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return mView
    }()
    
    lazy var doneButton: Button = {
        let button = Button()
        
        button.setTitle("Done", for: .normal)
        
        let height = 44.0
        let inset = 16.0
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            make.right.bottom.equalTo(-inset)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Select Location"
        
        mapView.isHidden = false
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.layoutIfNeeded()
        
        if let location = self.location {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.map.adjustRegion(with: coordinate)
        } else if let coordinate = LocationService.sharedInstance.currentLocation?.coordinate {
            mapView.map.adjustRegion(with: coordinate)
        }
    }
    
    // MARK: Action
    @objc private func doneTapped() {
        let location = prepareLocation()
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            var title: String
            
            if let _ = error {
                title = "Unknown place"
            } else {
                let dictionary = placemarks?.first?.addressDictionary
                title = dictionary?["Name"] as? String ?? ""
            }
            
            let loc = Location(title: title, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            SplashRouter.shared.showCreatePlace(with: loc)
        }
        
    }
    
    // MARK: Private
    private func prepareLocation() -> CLLocation {
        let point = CGPoint(x: mapView.pinView.frame.midX, y: mapView.pinView.frame.maxY)
        let coordinates = mapView.map.convert(point, toCoordinateFrom: nil)
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
}
