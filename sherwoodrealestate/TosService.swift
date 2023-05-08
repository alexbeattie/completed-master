//
//  TosService.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/15/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
class TosService {
    static let shared = TosService()
    
    func fetchDisclaimer(completion: @escaping ([Disclaimer], Error?) -> ()) {
        print("fetched items from tosservice layer")
        
        let urlString = "https://sherwoodrealestate.s3.amazonaws.com/disclaimer.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps", err)
                completion([], nil)
                return
            }
            guard let data = data else { return }
            do {
                let disclaimerFrom = try JSONDecoder().decode(DisclaimerModel.self, from: data)
                
                print(disclaimerFrom)
                completion(disclaimerFrom.Disclaimers, nil)
                
            } catch let jsonErr {
                print("Failed to decode JSON", jsonErr)
                completion([], jsonErr)
            }
            
        }.resume()
    }
}
