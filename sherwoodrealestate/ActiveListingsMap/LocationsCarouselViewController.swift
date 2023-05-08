//
//  LocationsCarouselViewController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/10/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools
import MapKit



class LocationCell: LBTAListCell<ListingAnno> {
    let label = UILabel(text: " ", font: .boldSystemFont(ofSize: 14), textAlignment: .center, numberOfLines: 1)
    let priceLabel = UILabel(text: " ", font: .systemFont(ofSize: 14), textAlignment: .center)
    let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        backgroundColor = .white
        
    }
    var image: UIImage? {
        get {
            return self.imageView.image
        }
        
        set {
            self.imageView.image = newValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let greyView = UIView()
    
    public func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    public func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    override var item: ListingAnno! {
        didSet {
            configureCell()
            activityIndicatorBegin()
            
            label.text = item.title?.localizedCapitalized
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.maximumFractionDigits = 0
            
            currencyFormatter.locale = Locale.current
            priceLabel.text = currencyFormatter.string(from: item?.subtitle! as! NSNumber)
            
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.masksToBounds = true
            imageView.constrainWidth(120)
            
            imageView.image = item.image
            
            activityIndicatorEnd()
        }
    }
    func configureCell() {
        activityIndicatorBegin()
        setupShadow(opacity: 0.1, radius: 5, offset: .zero, color: .black)
        layer.cornerRadius = 5
        clipsToBounds = true
        hstack(imageView, stack(label, priceLabel, spacing: 4).withMargins(.allSides(16)),
               alignment: .center)
        activityIndicatorEnd()
    }
}

class LocationsCarouselController: LBTAListController<LocationCell, ListingAnno> {
    weak var mapOfListingVC: MapOfListings?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let annotations = mapOfListingVC?.mapView.annotations
        annotations?.forEach({ (annotation) in
            guard let customAnnotation = annotation as? MapOfListings.CustomListingAnno else { return }
            if customAnnotation.listingItem == self.items[indexPath.item] {
                mapOfListingVC?.mapView.selectAnnotation(annotation, animated: true)
            }
        })
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func showAppDetailForApp(_ listing: ActiveListings.listingResults) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = ListingDetailController(collectionViewLayout: layout)
        appDetailController.listing = listing
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
    }
}
extension LocationsCarouselController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 64, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
