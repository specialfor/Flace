//
//  UIViewControllerExtension.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var theme: Theme {
        return ThemeManager.shared.theme
    }
    
}
