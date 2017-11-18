//
//  Theme.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

protocol Theme {
    
    var backgroundColor: UIColor { get }
    
    var mainColor: UIColor { get }
    var accentColor: UIColor { get }
    
    var textColor: UIColor { get }
    var selectedTextColor: UIColor { get }
    
    var darkGray: UIColor { get }
    
    var lightGray: UIColor { get }
    
}

extension Theme {
    
    var darkGray: UIColor {
        return UIColor.darkGray
    }
    
    var lightGray: UIColor {
        return UIColor.lightGray
    }
    
}
