//
//  CreatePlaceViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation.CLLocation

class CreatePlaceViewController: ViewController {
    
    var imageSelector: ImageSelector?
    
    var location: Location? {
        didSet {
            placeView.locationButton.setTitle(location!.title, for: .normal)
        }
    }
    
    // MARK: Views
    lazy var placeView: PlaceView = {
        let pView = PlaceView()
        
        self.view.addSubview(pView)
        pView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        return pView
    }()
    
    lazy var createButton: Button = {
        let button = Button()
        
        let inset = 16.0
        let height = 44.0
        
        button.setTitle("Create", for: .normal)
        
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            make.right.bottom.equalTo(-inset)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func initialize() {
        navigationItem.title = "Create Place"
        
        imageSelector = ImageSelector.sharedInstance
        imageSelector?.delegate = self
        
        placeView.locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        
        configureImageView()
    }
    
    // MARK: Configure
    private func configureImageView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        placeView.imageView.addGestureRecognizer(tapRecognizer)
        
        placeView.imageView.isUserInteractionEnabled = true
    }
    
    // MARK: Keyboard
    override func keyboardNotified(endFrame: CGRect) {
        if !isKeyboardGoingToHide(endFrame) {
            placeView.scrollView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(-endFrame.height)
            })
            
            var rect = placeView.titleField.frame
            rect.origin.y += 32.0
            
            placeView.scrollView.scrollRectToVisible(rect, animated: true)
        } else {
            placeView.scrollView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(0)
            })
        }
    }
    
    // MARK: Actions
    @objc private func imageTapped() {
        self.view.endEditing(false)
        
        imageSelector?.showPhotoActionSheet(navigation: navigationController!)
    }
    
    @objc private func locationTapped() {
        self.view.endEditing(false)
        
        SplashRouter.shared.showSelectLocation(location)
    }
    
    @objc private func createTapped() {
        if validate() {
            if let place = preparePlace() {
                StorageService.default.places.append(place)
                SplashRouter.shared.dismissToInitial()
            } else {
                AlertManager.sharedInstance.showAlertOk(message: "Something went wrond. Please, try again.")
            }
        } else {
            AlertManager.sharedInstance.showAlertOk(message: "Plase, select image, location or enter title.")
        }
    }
    
    // MARK: Private
    private func validate() -> Bool {
        let text = placeView.titleField.text ?? ""
        if let _ = placeView.imageView.image, let _ = location, !text.isEmpty {
            return true
        }
        
        return false
    }
    
    private func preparePlace() -> Place? {
        if let imageUrl = PhotoSaver().saveImage(placeView.imageView.image!) {
            let rating = arc4random_uniform(10)
            
            return Place(id: imageUrl, title: placeView.titleField.text!, image: imageUrl, location: location!, rating: Double(rating), isRated: false)
        }
        
        return nil
    }
}

extension CreatePlaceViewController: ImageSelectorDelegate {
    
    func selected(image: UIImage) {
        placeView.imageView.image = image
    }
    
    func imageSelectorCanceled() {
        // NOTE: do nothing
    }
    
}
