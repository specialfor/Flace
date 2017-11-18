//
//  SplashRouter.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class SplashRouter {
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }()
    
    var rootViewController: UIViewController {
        configureNavBar()
        
        showInitial()
        return navigationController
    }
    
    // MARK: Singleton
    static let shared = SplashRouter()
    
    private init() {}
    
    // MARK: Routes
    func showInitial() {
        showModule(MainViewController())
    }
    
    // MAKR: Show, present, dismiss
    private func showModule(_ viewController: UIViewController, animated: Bool = true, popPrev: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        
        if popPrev {
            navigationController.viewControllers = [navigationController.viewControllers.last!]
        }
    }
    
    private func present(_ viewController: UIViewController, animated: Bool = true) {
        if navigationController.presentedViewController != viewController {
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func dismiss(_ animated: Bool = true) {
        navigationController.dismiss(animated: animated, completion: nil)
    }
    
    private func configureNavBar() {
//        UIApplication.shared.statusBarStyle = .lightContent

        let navigationBar = navigationController.navigationBar

        let theme = ThemeManager.shared.theme

        navigationBar.barTintColor = theme.mainColor
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        navigationBar.tintColor = theme.selectedTextColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.selectedTextColor]

        navigationController.isNavigationBarHidden = false
    }
}
