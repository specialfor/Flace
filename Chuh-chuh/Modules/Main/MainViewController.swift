//
//  MainViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MainViewController: ViewController, LocationServiceDelegate {
    
    // MARK: Views
    lazy var mapView: MKMapView = {
        let mView = MKMapView()
        
        self.view.addSubview(mView)
        mView.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalToSuperview()
        })
        
        return mView
    }()
    
    lazy var addButton: Button = {
        let button = Button()
        
        let inset = 16.0
        let width: CGFloat = 52.0
        
        button.backgroundColor = theme.accentColor
        button.setTitle("+", for: .normal)
        
        button.layer.cornerRadius = width / 2
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.width.height.equalTo(width)
            make.right.bottom.equalTo(-inset)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Places Nearby"
        
        mapView.showsUserLocation = true
        
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationService.sharedInstance.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LocationService.sharedInstance.delegate = nil
    }
    
    // MARK: Actions
    @objc func addTapped() {
        SplashRouter.shared.showCreatePlace()
    }
    
    // MARK: LocationServiceDelegate
    func locationUpdated(location: CLLocation) {
        mapView.adjustRegion(with: location.coordinate)
        // TODO: calculate radius
    }
    
}
