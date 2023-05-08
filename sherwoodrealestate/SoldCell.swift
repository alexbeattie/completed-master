//
//  AppsGroupCell.swift
//  appStore
//
//  Created by Alex Beattie on 4/24/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit

class SoldCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Sold Section", font: .boldSystemFont(ofSize: 30))

    let horizontalController = AppsHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .purple
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
