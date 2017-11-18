//
//  Place.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Foundation

struct Place: Codable {
    
    let id: String
    let title: String
    let image: String
    let location: Location
    let rating: Double
    let isRated: Bool = false
    
}
