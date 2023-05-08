
//  Annotation.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import MapKit
import Contacts
import SDWebImage

class ListingAnno: NSObject, MKAnnotation {
    
    var anno: ActiveListings.listingResults?
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: Int?
    var image: UIImage?
    
    init(title:String, coordinate: CLLocationCoordinate2D, subTitle: Int, image: UIImage) {
        self.title = title.localizedCapitalized
        self.coordinate = coordinate
        self.subtitle = subTitle
        self.image = image
        super.init()
    }
}

