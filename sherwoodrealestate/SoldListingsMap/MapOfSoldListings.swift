//
//  MapOfSoldListings.swift
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

class MapOfSoldListings: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let greyView = UIView()
    
    public func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
    }
    
    public func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    //    var anno:ActiveListings.standardFields!
    var locationManager = CLLocationManager()
    var mapView = MKMapView()
    var listing: ActiveListings.listingResults? {
        didSet {
            
            if listing?.StandardFields.Photos != nil {
                return
            }
            if listing?.StandardFields.VirtualTours != nil {
                return
            }
            if listing?.StandardFields.Videos != nil {
                return
            }
            if listing?.StandardFields.Documents != nil {
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map of Previously Sold"
        checkLocationAuthorization()
        self.view = mapView
        mapView.delegate = self
        soldLocationsController.collectionView.reloadData()

        mapView.showsUserLocation = false
        
        setupRegionForMap()
//        self.fetchListings()
        setUpCarouselLocation()
        soldLocationsController.soldMapOfListingVC = self
    }
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 34.144404, longitude: -118.872124)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    let soldLocationsController = SoldLocationsCarouselController(scrollDirection: .horizontal)
    let homeController = HomeViewController()
    let ldvc = ListingDetailController()
    
    
    func setUpCarouselLocation() {
        let locationView = soldLocationsController.view!
        
        view.addSubview(locationView)
//        soldLocationsController.collectionView.reloadData()
        locationView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 150))
        soldLocationsController.collectionView.reloadData()

    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default: break
            
        }
    }
    class SoldCustomListingAnno:MKPointAnnotation {
        var listingItem: SoldListingsAnno?
        var imageUrl: UIImage?
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            SoldListings.fetchListing { (listing) in
                for anno in listing.D.Results {
                    let title = anno.StandardFields.UnparsedFirstLineAddress
                    let lat = anno.StandardFields.Latitude
                    let lon = anno.StandardFields.Longitude
                    let subTitle = anno.StandardFields.ListPrice
                    let image = URL(string: anno.StandardFields.Photos?[0].Uri640 ?? "")
                    let imageString = image
                    let coordinate = CLLocationCoordinate2DMake((lat ?? nil)!, (lon ?? nil)!)
                    
                    let listingItem = SoldListingsAnno(title: title ?? "", coordinate: coordinate, subTitle: subTitle ?? 0, image: UIImage())
                    let session = URLSession(configuration: .default)
                    let downloadPicTask = session.dataTask(with: imageString!) { (data, response, error) in
                        // The download has finished.
                        if let e = error {
                            print("Error downloading cat picture: \(e)")
                        } else {
                            if let _ = response as? HTTPURLResponse {
                                if let imageData = data {
                                    DispatchQueue.main.async {
                                        
                                        let image = UIImage(data: imageData)
                                        listingItem.image = image
                                    }
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code for some reason")
                            }
                        }
                    }
                    
                    downloadPicTask.resume()
                    
                    
                    let soldCustom = SoldCustomListingAnno()
                    soldCustom.listingItem = listingItem
                    
                    soldCustom.coordinate = listingItem.coordinate
                    soldCustom.title = listingItem.title
                    
                    self.mapView.addAnnotation(soldCustom)
                    self.soldLocationsController.items.append(listingItem)
                }
            
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            self.soldLocationsController.collectionView.reloadData()
            self.soldLocationsController.collectionView.scrollToItem(at: [0,0], at: .centeredHorizontally, animated: true)
            
        }
        //        self.fetchListings()
    }
    override func viewDidDisappear(_ animated: Bool) {
        soldLocationsController.items.removeAll()
        mapView.removeAnnotations(self.mapView.annotations)
    }
}



extension MapOfSoldListings: MKMapViewDelegate {
    
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
        
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let customAnnotation = view.annotation as? SoldCustomListingAnno else { return }
        guard let index = self.soldLocationsController.items.firstIndex(where: {$0.title == customAnnotation.listingItem?.title}) else { return }
        self.soldLocationsController.collectionView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: true)
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
