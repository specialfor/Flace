//
//  RaterView.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import Cosmos

class RaterView: CosmosView {
    
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
    private func baseSetup() {
        self.rating = 3.0
        self.settings.filledColor = theme.accentColor
    }
    
}
