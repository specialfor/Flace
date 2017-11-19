//
//  RatingListCellModel.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import CoreLocation.CLLocation

struct RatingListCellModel: CellModel {
    
    let index: Int
    let place: Place
    
}

extension RatingListCellModel {
    
    var distance: Double? {
        if let userLocation = LocationService.sharedInstance.currentLocation {
            let loc = CLLocation(latitude: place.location.latitude, longitude: place.location.longitude)
            return loc.distance(from: userLocation)
        }
        
        return nil
    }
    
}
