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
    
    func closeCreatePlace() {
        closeModule()
    }
    
    func showCreatePlace() {
        showModule(CreatePlaceViewController())
    }
    
    func showCreatePlace(with location: Location) {
        guard let vc = (navigationController.viewControllers.filter { $0 is CreatePlaceViewController }).first as? CreatePlaceViewController else {
            return
        }
        
        vc.location = location
        navigationController.popViewController(animated: true)
    }
    
    func showSelectLocation(_ location: Location? = nil) {
        let vc = SelectLocationViewController()
        vc.location = location
        showModule(vc)
    }
    
    func showLocationPreview(_ location: Location) {
        let vc = LocationPreviewViewController()
        vc.location = location
        showModule(vc)
    }
    
    func showImagePreview(_ image: UIImage) {
        navigationController.navigationBar.isHidden = true
        let vc = ImagePreviewViewController()
        vc.image = image
        showModule(vc, animated: false)
    }
    
    func closeImagePreview() {
        navigationController.navigationBar.isHidden = false
        closeModule(animated: false)
    }
    
    func showPlaceDetails(_ place: Place) {
        let vc = PlaceDetailsViewController()
        vc.place = place
        showModule(vc)
    }
    
    func showRatingList() {
        showModule(RatingListViewController())
    }
    
    // MAKR: Show, present, dismiss
    private func showModule(_ viewController: UIViewController, animated: Bool = true, popPrev: Bool = false) {
        navigationController.pushViewController(viewController, animated: animated)
        
        if popPrev {
            navigationController.viewControllers = [navigationController.viewControllers.last!]
        }
    }
    
    func closeModule(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
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
        UIApplication.shared.statusBarStyle = .lightContent

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
