//
//  PlaceAnnotation.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var place: Place

    init(coordinate: CLLocationCoordinate2D, place: Place) {
        self.coordinate = coordinate
        self.place = place
        self.title = place.title
    }
}
