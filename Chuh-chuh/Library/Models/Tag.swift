//
//  Tag.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Foundation

enum Tag: Int, Codable, Hashable {
    case romantic
    case relax
    case sport
    case extreme
    case art
    
    var title: String {
        return Tag.titles[self.rawValue]
    }
    
    static let titles = [
        "Romantic",
        "Relax",
        "Sport",
        "Extreme",
        "Art"
    ]
}
