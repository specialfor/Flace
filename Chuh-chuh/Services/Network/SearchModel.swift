//
//  SearchModel.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Foundation

struct SearchModel {
    
    let from: StationModel
    let to: StationModel
    let date: String /// dd.mm.yyyy
    let time: String /// hh:mm

    var dictionary: [String : Any] {
        return [
            "station_id_from" : from.id,
            "station_id_till" : to.id,
            "station_from" : from.title,
            "station_till" : to.title,
            "date_dep" : date,
            "time_dep" : time
        ]
    }
    
}
