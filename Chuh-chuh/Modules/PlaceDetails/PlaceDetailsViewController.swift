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
        placeView.imageView.image = UIImage(fileUrl: URL(string: place.image)!)
        
        placeView.titleField.isUserInteractionEnabled = false
        placeView.titleField.text = place.title
        
        placeView.locationButton.isUserInteractionEnabled = false
        placeView.locationButton.setTitle(place.location.title, for: .normal)
        
        raterView.isHidden = false
        raterView.isUserInteractionEnabled = !place.isRated
        raterView.text = place.isRated ? "Common Rating" : ""

        if !place.isRated {
            raterView.rating = min(place.rating / 10, 5)
            rateButton.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        }
    }
    
    // MARK: Actions
    @objc private func rateTapped() {
        raterView.isUserInteractionEnabled = false
        raterView.text = "Common Rating"
        rateButton.removeFromSuperview()
        
        place.rating += raterView.rating
        place.isRated = true
        
        raterView.rating = min(place.rating / 5, 5)
        
        let storageService = StorageService.default

        let index = storageService.places.index(where: { $0.id == place.id })!
        storageService.places[index] = place
    }
    
}
