//
//  LocationPreviewViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import MapKit

class LocationPreviewViewController: ViewController, MKMapViewDelegate {
 
    var location: Location!
    
    // MARK: Views
    lazy var mapView: MKMapView = {
        let mView = MKMapView()
        
        self.view.addSubview(mView)
        mView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return mView
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Location"
        
        mapView.showsUserLocation = true
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.addAnnotation(annotation)
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.layoutIfNeeded()
        
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        mapView.adjustRegion(with: coordinate)
    }
    
    // MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "PinIdentifier"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pin?.image = #imageLiteral(resourceName: "ic_map_pin_big")
            pin?.centerOffset = CGPoint(x: 0, y: -(pin!.image!.size.width / 2))
        } else {
            pin?.annotation = annotation
        }
        
        return pin
    }
    
}

