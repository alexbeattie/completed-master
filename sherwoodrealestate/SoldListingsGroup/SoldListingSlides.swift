//
//  ListingSlides.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools

class SoldListingSlides: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var listings: [SoldListings.listingResults]!
    var images:[String] = []
    var emptyPhotoArray = [String]()

    var listing: SoldListings.listingResults? {
        didSet {
            for aListing in (listing?.StandardFields.Photos)! {
                emptyPhotoArray.append(aListing.Uri640)
                self.images = emptyPhotoArray
            }
            
            DispatchQueue.main.async {
                self.activityIndicatorBegin()
                self.collectionView.reloadData()
                self.activityIndicatorEnd()
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        self.activityIndicatorBegin()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addSubview(collectionView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        
        collectionView.register(SoldListingImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = listing?.StandardFields.Photos?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoldListingImageCell
        let url = self.images[indexPath.row]
        
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: URLRequest(url: imageUrl)) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.imageView.image = nil
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    class SoldListingImageCell: BaseCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            imageView.image = nil
            setupViews()
            activityIndicatorBegin()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
        
        override func setupViews() {
            super.setupViews()
            stack(imageView)
        }
    }
}
