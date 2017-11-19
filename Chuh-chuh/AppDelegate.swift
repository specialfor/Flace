//
//  AppDelegate.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Configure window
        UIView.appearance().tintColor = ThemeManager.shared.theme.mainColor
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashRouter.shared.rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        StorageService.default.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StorageService.default.save()
    }

}

