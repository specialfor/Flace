//
//  Button.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    // MARK: Setup
    func baseSetup() {
        self.backgroundColor = ThemeManager.shared.theme.accentColor
        
        self.layer.cornerRadius = 6.0
        self.addShadow()
        
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
