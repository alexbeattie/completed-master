//
//  Disclaimer.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/13/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
struct DisclaimerModel: Decodable {
    let Disclaimers: [Disclaimer]
}
struct Disclaimer:Decodable {
    let PublicRemarks: String
}
