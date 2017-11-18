//
//  ThemeManager.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

class ThemeManager {
    
    /// Default: instance of 'MainTheme' struct
    var theme: Theme = MainTheme()
    
    // MARK: Singleton
    static let shared = ThemeManager()
    
    private init() {}
    
}
