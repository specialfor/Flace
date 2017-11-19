//
//  MKMapViewExtension.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import MapKit

extension MKMapView {
    
    func adjustRegion(with coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = Constants.radius) {
        var region = MKCoordinateRegionMakeWithDistance(coordinate, radius, radius)
        region = self.regionThatFits(region)
        self.setRegion(region, animated: true)
    }
    
    func reloadData() {
        let ann = self.annotations(in: self.visibleMapRect)
        let arrAnn = Array(ann) as! [MKAnnotation]
        self.removeAnnotations(arrAnn)
        self.addAnnotations(arrAnn)
    }
    
}
