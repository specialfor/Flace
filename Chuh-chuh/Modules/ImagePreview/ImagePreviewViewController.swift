//
//  ImagePreviewImagePreviewViewController.swift
//  Nynja
//
//  Created by Anton Makarov on 29/08/2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {

    var image: UIImage!
    
    // MARK: Views
    lazy var imgView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        
        self.view.addSubview(v)
        
        v.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        return v
    }()
    
    lazy var gradientView: GradientView = {
        var colors: [UIColor] = [.clear, .black]
        
        let gv = GradientView(colors: colors)
        
        self.view.addSubview(gv)
        gv.snp.makeConstraints({ (make) in
            make.height.equalTo(100.0)
            make.left.right.bottom.equalToSuperview()
        })
        
        return gv
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
        
        button.contentHorizontalAlignment = .left
        
        self.gradientView.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.height.equalTo(44.0)
            make.width.equalTo(80.0)
            make.left.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().offset(-16.0)
        })
        
        return button
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = image
        view.bringSubview(toFront: closeButton)
    }
    
    // MARK: Actions
    @objc func closeTapped(_ sender: UIButton) {
        SplashRouter.shared.closeImagePreview()
    }
}

