//
//  SoldLocationsCarousel.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import UIKit
import LBTATools
import MapKit

class SoldLocationCell: LBTAListCell<SoldListingsAnno> {
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
    
    var listings:[SoldListings.listingResults]?
    var homeController:HomeViewController?
    override var item: SoldListingsAnno! {
        didSet {
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
    let soldCV:SoldLocationsCarouselController? = nil
    
    let label = UILabel(text: "This is a road", font: .boldSystemFont(ofSize: 16), textAlignment: .center, numberOfLines: 1)
    let priceLabel = UILabel(text: "Address", font: .systemFont(ofSize: 14), textAlignment: .center)
    let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
    
    override func setupViews() {
        setupShadow(opacity: 0.1, radius: 5, offset: .zero, color: .black)
        layer.cornerRadius = 5
        clipsToBounds = true
        hstack(imageView, stack(label, spacing: 4).withMargins(.allSides(16)),
               alignment: .center)
        soldCV?.collectionView.reloadData()
    }
}

class SoldLocationsCarouselController: LBTAListController<SoldLocationCell, SoldListingsAnno> {
    
    weak var soldMapOfListingVC: MapOfSoldListings?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let annotations = soldMapOfListingVC?.mapView.annotations
        annotations?.forEach({ (annotation) in
            guard let customAnnotation = annotation as? MapOfSoldListings.SoldCustomListingAnno else { return }
            if customAnnotation.listingItem == self.items[indexPath.item] {
                soldMapOfListingVC?.mapView.selectAnnotation(annotation, animated: true)
            }
        })
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.reloadData()
    }
}
extension SoldLocationsCarouselController: UICollectionViewDelegateFlowLayout {
    
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
