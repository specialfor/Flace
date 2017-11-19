//
//  Place.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Foundation

class Place: Codable {
    
    let id: String
    let title: String
    let image: String
    let location: Location
    var rating: Double
    var isRated: Bool
    
    init(id: String, title: String, image: String, location: Location, rating: Double, isRated: Bool) {
        self.id = id
        self.title = title
        self.image = image
        self.location = location
        self.rating = rating
        self.isRated = isRated
    }
    
}
