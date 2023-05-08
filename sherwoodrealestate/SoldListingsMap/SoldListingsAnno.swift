//
//  SoldListingsAnno.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/21/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import MapKit
import Contacts
import SDWebImage

class SoldListingsAnno: NSObject, MKAnnotation {
    
    var anno: SoldListings.listingResults?
    
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

