//
//  DisclaimerHeader.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/18/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
import UIKit

class DisclaimerHeader: UICollectionReusableView {
    let headerLabel = UILabel(text: "Legal Disclaimer", font: .boldSystemFont(ofSize: 20), textAlignment: .center, numberOfLines: 1)
    override init(frame: CGRect) {
        super.init(frame: frame)
        stack(headerLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
