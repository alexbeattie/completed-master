//
//  ViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import SDWebImage

class SoldListingsHomeController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let footerId = "footerId"

    var authToken:SoldListings.resultsArr!
    var listings: [SoldListings.listingResults]?
    var photos : [SoldListings.standardFields.PhotoDictionary]?
    
    var listingInfo:SoldListings?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicatorBegin()
        collectionView.backgroundColor = .white

        SoldListings.fetchListing { (listings) in
            self.listings = listings.D.Results
            self.collectionView?.reloadData()
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        self.activityIndicatorEnd()
        navigationController?.navigationBar.isTranslucent = true
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.compactAppearance = .none
        } else {
            // Fallback on earlier versions
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.title = "Previously Sold"
        collectionView.register(SoldLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)

        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(SoldListingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self

    }

    func showSoldListingDetailController(_ listing: SoldListings.listingResults) {
        let layout = UICollectionViewFlowLayout()
        let soldListingDetailController = SoldListingDetailController(collectionViewLayout: layout)
        
        soldListingDetailController.listing = listing
        //print(listing.Id)
        navigationController?.pushViewController(soldListingDetailController, animated: true)
    }
    
    // MARK: - Home CollectionViewController
    
    let homeCollectionView:UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return collectionView
        
    }()
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoldListingsCell
        
        cell.listing = listings?[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = listings?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listing = listings?[indexPath.item] {
            showSoldListingDetailController(listing)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 2
      }
}

class SoldListingsCell: UICollectionViewCell {
    var listing: SoldListings.listingResults? {
        didSet {
            UserDefaults.standard.object(forKey: "AuthToken")
            imageView.image = nil
            imageView.sd_setImage(with: URL(string: listing?.StandardFields.Photos?[0].Uri640 ?? ""))
            if let theAddress = listing?.StandardFields.UnparsedFirstLineAddress?.localizedCapitalized {
                nameLabel.text = theAddress
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        backgroundView = .init(backgroundColor: .white)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.contentView.layer.cornerRadius
        setupViews()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), textColor: .white, textAlignment: .center)
    //        let costLabel = UILabel(text: "", font: .systemFont(ofSize: 14), textColor: .white, textAlignment: .center)
    let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
    
    func setupViews() {
        backgroundColor = .white
        stack(imageView)
        setupGradientLayer()
        stack(UIView(),nameLabel).withMargins(.allSides(8))
        
    }
    let gradientLayer = CAGradientLayer()
    
    func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.2]
        layer.masksToBounds = true
        layer.addSublayer(gradientLayer)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}


