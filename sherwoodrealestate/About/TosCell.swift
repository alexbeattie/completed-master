//
//  TosCellItem.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
import UIKit

class TosCell: UICollectionViewCell {
    let titleLabel = UILabel(text: "33", font: .systemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let repNameLabel = UILabel(text: "alex", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center, numberOfLines: 0)
    let jobTitleRemarks = UILabel(text: "alex", font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 0)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var dis: Disclaimer? {
        didSet {
            guard let dis = dis else { return }
            jobTitleRemarks.text = dis.PublicRemarks
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {
        
        stack(imageView, repNameLabel,titleLabel,jobTitleRemarks,separatorView.withHeight(24),UIView(), spacing: 4, alignment: .center, distribution: .equalSpacing).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
