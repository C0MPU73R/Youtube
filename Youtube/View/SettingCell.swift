//
//  SettingCell.swift
//  Youtube
//
//  Created by Noshaid Ali on 10/12/17.
//  Copyright © 2017 Cricingif. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.nameLabel)
        self.addSubview(self.iconImageView)
        
        self.addConstraintsWith(format: "H:|-8-[v0(30)]-8-[v1]|", views: self.iconImageView, self.nameLabel)
        self.addConstraintsWith(format: "V:|[v0]|", views: self.nameLabel)
        self.addConstraintsWith(format: "V:[v0(30)]", views: self.iconImageView)
        
        self.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
