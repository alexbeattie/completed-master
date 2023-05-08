//
//  AppRowCell.swift
//  appStore
//
//  Created by Alex Beattie on 4/25/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
//import L
//rows that stack up in cells 3 down and ... across
class SoldRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let getButton = UIButton(title: "GET")
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(58)
        imageView.constrainHeight(58)
        
        
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(80)
        getButton.constrainHeight(32)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        
        getButton.layer.cornerRadius = 32 / 2
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
