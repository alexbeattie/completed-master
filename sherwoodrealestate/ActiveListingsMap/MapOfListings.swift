//
//  MapOfListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/3/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import LBTATools
import SDWebImage

class MapOfListings: UIViewController {
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
    
//    let homeVC : MapOfListings? = nil
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ActiveListings.fetchListing { (listing) in
            for anno in listing.D.Results {
                
                let title = anno.StandardFields.UnparsedFirstLineAddress
                let lat = anno.StandardFields.Latitude
                let lon = anno.StandardFields.Longitude
                let subTitle = anno.StandardFields.ListPrice
                let image = URL(string: anno.StandardFields.Photos?[0].Uri640 ?? "")
                let imageView = UIImageView(image: UIImage(named:"pic"), contentMode: .scaleAspectFill)
                let imageString = image
                
                let coordinate = CLLocationCoordinate2DMake((lat ?? 0), (lon ?? 0))
                let listingItem = ListingAnno(title: title ?? "", coordinate: coordinate, subTitle: subTitle ?? 0, image: UIImage())
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: imageString!) { (data, response, error) in
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            listingItem.image = image
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    }
                }
                
//                DispatchQueue.main.async {
                    downloadPicTask.resume()
//                }
                self.activityIndicatorEnd()
                
                let theCustom = CustomListingAnno()
                imageView.sd_setImage(with: URL(string: anno.StandardFields.Photos?[0].Uri640 ?? ""))

                theCustom.listingItem = listingItem
                theCustom.coordinate = listingItem.coordinate
                theCustom.title = listingItem.title
                theCustom.subtitle = listingItem.subtitle as? String
                                DispatchQueue.main.async {

//                DispatchQueue.main.async {
                                }
                    self.mapView.addAnnotation(theCustom)
                    self.locationsController.items.append(listingItem)
              
            }
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            self.locationsController.collectionView.reloadData()
            self.locationsController.collectionView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true)

        }

//        self.locationsController.collectionView.reloadData()
        
        
        self.fetchListings()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Map of Listings"
        checkLocationAuthorization()
        self.view = mapView
        mapView.delegate = self
        
        mapView.showsUserLocation = false
        
        setupRegionForMap()
        self.fetchListings()
        setUpCarouselLocation()
        locationsController.mapOfListingVC = self
        
        
    }
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 34.144404, longitude: -118.872124)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    let locationsController = LocationsCarouselController(scrollDirection: .horizontal)
    
    func setUpCarouselLocation() {
        
        let locationView = locationsController.view!
        
        view.addSubview(locationView)
        locationsController.collectionView.reloadData()
        
        locationView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 150))
        locationsController.collectionView.reloadData()

    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            
        }
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied: // Show alert telling users how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted: // Show an alert letting them know what’s up
            break
        case .authorizedAlways:
            break
        @unknown default: break
            
        }
    }
    
    class CustomListingAnno:MKPointAnnotation {
        var listingItem: ListingAnno?
        var imageUrl: UIImage?
    }
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let greyView = UIView()
    
    public func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    public func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
    }
    
    func fetchListings() {}
    override func viewDidDisappear(_ animated: Bool) {
        locationsController.items.removeAll()
        mapView.removeAnnotations(self.mapView.annotations)
    }
}

extension MapOfListings: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?  {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true
        annotationView.pinTintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        annotationView.rightCalloutAccessoryView = rightButton
        self.locationsController.collectionView.reloadData()

//        if annotationView is CustomListingAnno {
//            annotationView.isSelected = true
//        }
//        locationsController.collectionView.reloadData()

        return annotationView
//        locationsController.collectionView.reloadData()

        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let customAnnotation = view.annotation as? CustomListingAnno else { return }
        guard let index = self.locationsController.items.firstIndex(where: {$0.title == customAnnotation.listingItem?.title}) else { return }
        self.locationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
        self.locationsController.collectionView.reloadData()
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let placemark = MKPlacemark(coordinate: view.annotation!.coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = view.annotation!.title!
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

