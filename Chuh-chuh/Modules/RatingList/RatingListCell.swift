//
//  RatingListCell.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import SnapKit

class RatingListCell: UITableViewCell, ConfigurableCell {
    
    static var cellId: String = "RatingListCell"
    static let height: CGFloat = 66.0
    
    
    // MARK: Views
    lazy var photoImageView: UIImageView = {
        let imgView = UIImageView()
        
        let width = 50.0
        let verticalInset = 8.0
        
        imgView.contentMode = .scaleAspectFill
        
        imgView.layer.cornerRadius = 6.0
        imgView.layer.masksToBounds = true
        
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints({ (make) in
            make.width.height.equalTo(width)
            make.top.equalTo(verticalInset)
            make.bottom.equalTo(-verticalInset)
            make.left.equalTo(16.0)
        })
        
        return imgView
    }()
    
    lazy var labelsView: UIView = {
        let view = UIView()
        
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.left.equalTo(photoImageView.snp.right).offset(8.0)
            make.centerY.equalToSuperview()
        })
        
        return view
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = theme.textColor
        
        self.labelsView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = theme.textColor
        
        self.labelsView.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(positionLabel.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        })
        
        return label
    }()
    
    lazy var raterView: RaterView = {
        let rView = RaterView()
        
        rView.setContentHuggingPriority(.required, for: .horizontal)
        
        self.contentView.addSubview(rView)
        rView.snp.makeConstraints({ (make) in
            make.left.equalTo(labelsView.snp.right).offset(8.0)
            make.right.equalTo(-16.0)
            make.centerY.equalToSuperview()
        })
        
        return rView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        
        let inset = 16.0
        
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.height.equalTo(1)
            make.left.equalTo(inset)
            make.right.equalTo(-inset)
            make.bottom.equalToSuperview()
        })
        
        return view
    }()
    
    // MARK: Setup
    func setup(with model: CellModel) {
        guard let ratingModel = model as? RatingListCellModel else {
            return
        }
        
        backgroundColor = .clear
        selectionStyle = .none
        
        photoImageView.image = UIImage(path: ratingModel.place.image)!
        
        positionLabel.text = "\(ratingModel.index)."
        titleLabel.text = ratingModel.place.title
        
        raterView.isUserInteractionEnabled = false
        raterView.rating = ratingModel.place.normRating
        
        separatorView.backgroundColor = theme.lightGray
    }

}
