//
//  SoldListingDetailController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/8/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

//
//  ListingDetailController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MapKit
import CoreLocation
import MessageUI

class SoldListingDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, UIActivityItemSource {
    let cellId = "cellId"
    let footerId = "footerId"
    let descriptionId = "descriptionId"
    let headerId = "headerId"
    let titleId = "titleId"
    let mapId = "mapId"
    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    
    var mapView:MKMapView!
    let pin = MKPointAnnotation()
    var region: MKCoordinateRegion!
    let locationManager = CLLocationManager()
    var authToken:[SoldListings.resultsArr]?
    var expires:[SoldListings.resultsArr]?
      
    var listing: SoldListings.listingResults? {
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
    var theToken: SoldListings.resultsArr?
 
    @objc func handleNext() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.register(SoldListingSlides.self, forCellWithReuseIdentifier: cellId)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action:#selector(handleNext))
        
        collectionView?.register(SoldListingInfoCell.self, forCellWithReuseIdentifier: titleId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.register(MapCell.self, forCellWithReuseIdentifier: mapId)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.backgroundColor = UIColor.white
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupNavBarButtons()
    }
    
    lazy var itemsToShare = listing?.StandardFields.UnparsedAddress
    @objc func didTapSearchButton() {
        let items = [itemsToShare]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
        print("we search")
    }
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return (Any).self
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if activityType == .some(.postToFacebook) {
            return "Facebook"
        }
        if activityType == .some(.mail) {
            return "Send Us a Message"
        }
        if activityType == .some(.message) {
            return "send us a text"
        }
        return nil
    }
    func setupNavBarButtons() {
        _ = UIImage(named: "movie")?.withRenderingMode(.alwaysOriginal)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapSearchButton))
        
        let videoButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(handleVideo))
        navigationItem.rightBarButtonItems = [shareButton, videoButton]
    }

    @objc func handleVideo(url:NSURL) {
        guard let vidUrl = listing?.StandardFields.VirtualTours?.first?.Uri else { return }
        print(vidUrl)
        let url = URL(string:vidUrl)
        let player = AVPlayer(url: url!)
        
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    var toolbar:UIToolbar!
    @objc func addMe(sender: UIBarButtonItem) {
        let textToShare = (listing?.StandardFields.UnparsedFirstLineAddress)
        guard let site = NSURL(string: (listing?.StandardFields.Photos?[0].Uri800)!) else { return }
        let objectsToShare = [textToShare ?? "", site] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func sendMail(sender: UIBarButtonItem) {
        print("nothing")
        if MFMailComposeViewController.canSendMail() {
            var newMessage = ""
            if let msg = listing?.StandardFields.UnparsedAddress {
                newMessage = msg
            }
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>Can you send me information about \(newMessage)</p>" , isHTML: true)
            present(mail, animated: true)
        } else {
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleId, for: indexPath) as! SoldListingInfoCell
            cell.listing = listing
            return cell
        }
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
        if indexPath.item == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapId, for: indexPath) as! MapCell
            cell.mapView.mapType = .standard
            cell.mapView.delegate = self
            if let lat = listing?.StandardFields.Latitude, let lng = listing?.StandardFields.Longitude {
                
                let location = CLLocationCoordinate2DMake(lat, lng)
                let coordinateRegion = MKCoordinateRegion.init(center: location, latitudinalMeters: 27500.0, longitudinalMeters: 27500.0)
                cell.mapView.setRegion(coordinateRegion, animated: true)
                
                let pin = MKPointAnnotation()
                pin.coordinate = location
                pin.title = listing?.StandardFields.UnparsedFirstLineAddress
                
                cell.mapView.addAnnotation(pin)
            }
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SoldListingSlides
        cell.listing = listing
        return cell
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor =  #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        rightButton.setImage(UIImage(named: "small-pin-map-7"), for: UIControl.State())
        
        annoView.rightCalloutAccessoryView = rightButton
        
        //Add a LEFT IMAGE VIEW
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFill
        
        if let thumbnailImageUrl = listing?.StandardFields.Photos?[0].Uri640 {
            leftIconView.loadImageUsingUrlString(urlString: (thumbnailImageUrl))
        }
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        leftIconView.clipsToBounds = true
        annoView.leftCalloutAccessoryView = leftIconView
        
        return annoView
    }
    func goOutToGetMap() {
        
        
        let lat = listing?.StandardFields.Latitude
        let lng = listing?.StandardFields.Longitude
        let location = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        
        let item = MKMapItem(placemark: placemark)
        item.name = listing?.StandardFields.UnparsedAddress
        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
                                         MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
                                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
            self.goOutToGetMap()
        }
        alertController.addAction(OKAction)
        
        present(alertController, animated: true) { }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        alertController.addAction(cancelAction)
    }
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 12
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
        if let desc = listing?.StandardFields.PublicRemarks {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        }
        
        return attributedText
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 100)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height)
        }
        if indexPath.item == 2 {
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        if indexPath.item == 3 {
            
            
            return CGSize(width: view.frame.width, height: 250)
            
        }
        return CGSize(width: view.frame.width, height: 300)
    }
}


class SoldTitleCell: BaseCell {
    var listing: SoldListings.listingResults? {
        didSet {
            if let theAddress = listing?.StandardFields.UnparsedAddress {
                nameLabel.text = theAddress
            }
            if let lid = listing?.StandardFields.ListingId {
                listingIdLabel.text = lid
            }
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "400"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let listingIdLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    override func setupViews() {
        
        addSubview(viewContainer)
        addSubview(nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: viewContainer)
        addConstraintsWithFormat(format: "V:|[v0(80)]|", views: viewContainer)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]-8-|", views: nameLabel)
    }
}
class SoldAppDetailDescriptionCell: BaseCell {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat(format: "V:|-[v0]-|", views: textView)
    }
}



class SoldMapCell: BaseCell, MKMapViewDelegate  {
    
    var mapView = MKMapView()
    var listing: SoldListings? {
        willSet {
        }
    }
    override func setupViews() {
        
        addSubview(mapView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: mapView)
    }
}

