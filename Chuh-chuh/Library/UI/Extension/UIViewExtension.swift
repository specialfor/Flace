//
//  UIViewExtension.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

extension UIView {
    
    var theme: Theme {
        return ThemeManager.shared.theme
    }
    
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.7
    }
    
}
