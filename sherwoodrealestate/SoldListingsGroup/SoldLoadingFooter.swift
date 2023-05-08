//
//  SoldLoadingFooter.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/6/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
import UIKit

class SoldLoadingFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let aiv = UIActivityIndicatorView.init(style: .medium)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        stack(aiv, label, alignment: .center).withMargins(.init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
