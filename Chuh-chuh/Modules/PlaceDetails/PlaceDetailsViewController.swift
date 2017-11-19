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
    
    // MARK:
    lazy var scrollView: UIScrollView = {
        let sView = UIScrollView()
        
        sView.isUserInteractionEnabled = true
        
        self.view.addSubview(sView)
        sView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return sView
    }()
    
    lazy var contentView: UIView = {
        let cView = UIView()
        
        self.scrollView.addSubview(cView)
        cView.snp.makeConstraints({ (make) in
            make.top.bottom.left.right.equalTo(scrollView)
            make.width.equalTo(self.view)
        })
        
        return cView
    }()
    
    lazy var placeView: PlaceView = {
        let pView = PlaceView()
        
        contentView.addSubview(pView)
        pView.snp.makeConstraints({ (make) in
            make.left.top.right.equalToSuperview()
        })
        
        return pView
    }()
    
    lazy var raterView: RaterView = {
        let rView = RaterView()
        
        let inset = 16.0
        let height = 30.0
        
        contentView.addSubview(rView)
        rView.snp.makeConstraints({ (make) in
            make.top.equalTo(placeView.snp.bottom).offset(24)
            
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
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.centerY.equalTo(raterView)
            
            make.left.equalTo(raterView.snp.right).offset(inset)
            make.right.equalTo(-inset)
        }
        
        return button
    }()
    
    lazy var deleteButton: Button = {
        let button = Button()
        
        button.setTitle("Delete", for: .normal)
        
        let height = 44.0
        let inset = 16.0
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            
            make.left.equalTo(inset)
            make.bottom.equalTo(-inset)
        }
        
        return button
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        configureImageView()
        
        placeView.titleField.isUserInteractionEnabled = false
        placeView.titleField.text = place.title
        
        placeView.locationButton.setTitle(place.location.title, for: .normal)
        placeView.locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        
        raterView.isHidden = false
        adjustRatingView(isRated: place.isRated)
        
        if !place.isRated {
            rateButton.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        }
        
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        configureSegment()
    }
    
    private func adjustRatingView(isRated: Bool) {
        raterView.isUserInteractionEnabled = !isRated
        raterView.text = isRated ? "Common Rating" : ""
        raterView.rating = place.normRating
    }
    
    private func configureImageView() {
        placeView.imageView.image = UIImage(path: place.image)!
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        placeView.imageView.addGestureRecognizer(tapRecognizer)
        
        placeView.imageView.isUserInteractionEnabled = true
    }
    
    private func configureSegment() {
        placeView.segmentControl.isUserInteractionEnabled = false
        placeView.segmentControl.selectedSegmentIndexes = IndexSet(place.tags.map { $0.rawValue })
    }
    
    // MARK: Actions
    @objc private func deleteTapped() {
        let storage = StorageService.default
        storage.places.remove(at: storage.places.index(of: place)!)
        storage.save()
        
        SplashRouter.shared.closeModule()
    }
    
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
    
    @objc private func imageTapped() {
        SplashRouter.shared.showImagePreview(placeView.imageView.image!)
    }
}
