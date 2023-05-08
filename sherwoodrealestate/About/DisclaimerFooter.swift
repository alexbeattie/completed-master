//
//  DisclaimerFooter.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/18/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
import UIKit
import LBTATools

class DisclaimerFooter: UICollectionReusableView {
    let footerLabel = UILabel(text: " ", font: .boldSystemFont(ofSize: 20), textAlignment: .center, numberOfLines: 1)
    let emailLabelTV: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.dataDetectorTypes = .all
        tv.text = "mgrisolia@sherwooddc.com"
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 13)
        tv.textAlignment = .center
        tv.textColor = .systemBlue
        tv.backgroundColor = .clear
        return tv
    }()
    let emailLabelTVOne: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.dataDetectorTypes = .all
        tv.text = "lalaimo@sherwooddc.com"
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 13)
        tv.textAlignment = .center
        tv.textColor = .systemBlue
        tv.backgroundColor = .clear
        return tv
    }()
    let call: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.dataDetectorTypes = .all
        tv.text = "805.373.5992"
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 14)
        tv.textAlignment = .center
        tv.textColor = .systemBlue
        tv.backgroundColor = .clear
        return tv
    }()
    let addressTV: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.dataDetectorTypes = .all
        tv.text = "2300 Norfield Ct, Thousand Oaks, CA 91361"
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 14)
        tv.textAlignment = .center
        tv.textColor = .systemBlue
        tv.backgroundColor = .clear
        return tv
    }()
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "footer-logo-span-sherwood")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.905343771, green: 0.905343771, blue: 0.905343771, alpha: 1)
        stack(hstack(footerLabel, spacing:0, alignment:.top, distribution: .fill),
              hstack(addressTV, alignment:.top, distribution: .fillEqually).withHeight(24),
              hstack(emailLabelTVOne, emailLabelTV, spacing:0, alignment:.top, distribution: .fillEqually).withHeight(24),
              hstack(call, spacing:0, alignment:.top, distribution: .fillEqually).withHeight(24), UIView(),
              hstack(iconImageView, spacing:0, alignment:.top, distribution: .equalCentering).withWidth(200).withHeight(36)).withMargins(.init(top: 8, left: 8, bottom: 8, right: 8))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
