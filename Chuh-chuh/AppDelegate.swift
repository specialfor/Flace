//
//  AppDelegate.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        // Configure window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashRouter.shared.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

