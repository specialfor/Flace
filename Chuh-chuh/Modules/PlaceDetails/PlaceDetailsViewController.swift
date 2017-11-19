//
//  PlaceDetailsViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: ViewController {
    
    var place: Place!
    
    // MARK: Views
    lazy var placeView: PlaceView = {
        let pView = PlaceView()
        
        self.view.addSubview(pView)
        pView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return pView
    }()
    
    lazy var raterView: RaterView = {
        let rView = RaterView()
        
        let inset = 16.0
        let height = 30.0
        
        self.view.addSubview(rView)
        rView.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            make.bottom.equalTo(-inset)
            make.right.equalTo(-inset).priority(750)
        })
        
        return rView
    }()
    
    lazy var rateButton: Button = {
        let button = Button()
        
        button.setTitle("Rate", for: .normal)
        
        let height = 44.0
        let inset = 16.0
        
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            
            make.left.equalTo(raterView.snp.right).offset(inset)
            make.right.bottom.equalTo(-inset)
        }
        
        return button
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        placeView.imageView.image = UIImage(path: place.image)!
        
        placeView.titleField.isUserInteractionEnabled = false
        placeView.titleField.text = place.title
        
        placeView.locationButton.setTitle(place.location.title, for: .normal)
        placeView.locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        
        raterView.isHidden = false
        adjustRatingView(isRated: place.isRated)
        
        if !place.isRated {
            rateButton.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        }
    }
    
    private func adjustRatingView(isRated: Bool) {
        raterView.isUserInteractionEnabled = !isRated
        raterView.text = isRated ? "Common Rating" : ""
        raterView.rating = place.normRating
    }
    
    // MARK: Actions
    @objc private func locationTapped() {
        SplashRouter.shared.showLocationPreview(place.location)
    }
    
    @objc private func rateTapped() {
        rateButton.removeFromSuperview()
        
        place.rating += raterView.rating
        place.isRated = true
        
        adjustRatingView(isRated: place.isRated)
        
        let storageService = StorageService.default

        let index = storageService.places.index(where: { $0.id == place.id })!
        storageService.places[index] = place
    }
    
}
