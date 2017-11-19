//
//  MapView.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import MapKit

class MapView: View {
    
    // MARK: Views
    lazy var map: MKMapView = {
        let mView = MKMapView()
        
        self.addSubview(mView)
        mView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return mView
    }()
    
    lazy var pinView: UIImageView = {
        let imageView = UIImageView()
        
        let width = 56.0
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints( { (make) in
            make.width.height.equalTo(width)
            make.centerX.equalTo(map)
            make.centerY.equalTo(map).offset(-(width / 2))
        })
        
        return imageView
    }()
    
    // MARK: Setup
    override func baseSetup() {
        map.showsUserLocation = true
        pinView.image = #imageLiteral(resourceName: "ic_map_pin_big")
    }
    
}
