//
//  CreatePlaceViewController.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import SnapKit

class CreatePlaceViewController: ViewController {
    
    var imageSelector: ImageSelector?
    
    // MARK: Views
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
        
        scrollView.addSubview(cView)
        cView.snp.makeConstraints({ (make) in
            make.top.bottom.left.right.equalTo(scrollView)
            make.width.equalTo(view)
            make.height.equalTo(view).priority(250)
        })
        
        return cView
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        
        let width = UIScreen.main.bounds.width
        
        imgView.backgroundColor = .red
        imgView.clipsToBounds = false
        
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints({ (make) in
            make.width.height.equalTo(width)
            make.left.top.right.equalToSuperview()
        })
        
        return imgView
    }()
    
    lazy var titleField: UITextField = {
        let tField = UITextField()
        
        tField.placeholder = "Enter title"
        tField.borderStyle = .roundedRect
        
        let inset = 16.0
        let height = 44.0
        
        contentView.addSubview(tField)
        tField.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            
            make.top.equalTo(imageView.snp.bottom).offset(inset)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
        })
        
        return tField
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()

        button.setTitleColor(theme.textColor, for: .normal)
        
        button.setTitle("Select Location", for: .normal)
        button.setImage(#imageLiteral(resourceName: "ic_map_pin_small"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 0)
        
        button.contentHorizontalAlignment = .left
        
        let inset = 16.0
        let height = 44.0
        
        contentView.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            
            make.top.equalTo(titleField.snp.bottom).offset(inset)
            make.left.right.equalTo(titleField)
            
            make.bottom.greaterThanOrEqualTo(-16)
        })
        
        return button
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
        
        locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        
        configureImageView()
    }
    
    // MARK: Configure
    private func configureImageView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        
        imageView.isUserInteractionEnabled = true
    }
    
    // MARK: Keyboard
    override func keyboardNotified(endFrame: CGRect) {
        if !isKeyboardGoingToHide(endFrame) {
            scrollView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(-endFrame.height)
            })
            
            var rect = titleField.frame
            rect.origin.y += 32.0
            
            scrollView.scrollRectToVisible(rect, animated: true)
        } else {
            scrollView.snp.updateConstraints({ (make) in
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
        
        // TODO: show location screen
    }
    
    @objc private func createTapped() {
        // TODO: show main screen
    }
}

extension CreatePlaceViewController: ImageSelectorDelegate {
    
    func selected(image: UIImage) {
        imageView.image = image
    }
    
    func imageSelectorCanceled() {
        // NOTE: do nothing
    }
    
}
