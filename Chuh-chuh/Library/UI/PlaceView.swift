//
//  PlaceView.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

class PlaceView: View {
    
    // MARK: Views
    lazy var scrollView: UIScrollView = {
        let sView = UIScrollView()
        
        sView.isUserInteractionEnabled = true
        
        self.addSubview(sView)
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
            make.width.equalTo(self)
            make.height.equalTo(self).priority(250)
        })
        
        return cView
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        
        let width = UIScreen.main.bounds.width

        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        
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
        button.setImage(#imageLiteral(resourceName: "pin"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
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
    
    
    // MARK: Setup
    override func baseSetup() {
        imageView.image = #imageLiteral(resourceName: "placeholder")
        locationButton.isHidden = false
    }
    
}
