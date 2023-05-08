//
//  TeamModel.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/12/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
struct TeamResult: Decodable {
    let Results: [Result]
}
struct Result:Decodable {
    let Id: String
    let Representative: String
    let JobTitle: String
    let PublicRemarks: String
    let imageUrl: String
}
