//
//  Listing.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
struct ActiveListings: Codable {
    
    static let shared = ActiveListings()
    
    struct responseData: Codable {
        var D: ResultsData
    }
    struct resultsArr: Codable {
           var AuthToken: String
           var Expires: String
       }
    struct ResultsData: Codable {
        var Results: [resultsArr]
        
    }
    struct Pagination: Codable {
        var totalRows: Int
        var pageSize: Int
        var currentPage: Int
        var totalPages: Int

        init(totalRows: Int? = nil, pageSize: Int? = nil, currentPage:Int? = nil, totalPages:Int? = nil) {
            self.totalRows = totalRows ?? 0
            self.pageSize = pageSize ?? 0
            self.currentPage = currentPage ?? 0
            self.totalPages = totalPages ?? 0
        }
       private enum CodingKeys: String, CodingKey {
            case totalRows = "totalRows"
            case pageSize = "pageSize"
            case currentPage = "currentPage"
            case totalPages = "totalPages"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            totalRows = try container.decode(Int.self, forKey: .totalRows)
            pageSize = try container.decode(Int.self, forKey: .pageSize)
            currentPage = try container.decode(Int.self, forKey: .currentPage)
            totalPages = try container.decode(Int.self, forKey: .totalPages)
        }

    }
   
    //    static let instance = Listing()
  

    //listing struct
    struct listingData: Codable {
        var D: listingResultsData
    }
    struct listingResultsData: Codable {
        var Results: [listingResults]
    }
   

    struct listingResults: Codable {
        var Id: String
        var ResourceUri: String
        var StandardFields: standardFields
//        var lastCachedTimestamp: JSONNull?
        

    }

  

    struct standardFields: Codable {
        
        var BedsTotal: String
        var BathsFull: String
        var BuildingAreaTotal: Float?
        let Latitude: Double?
        let Longitude: Double?
        
        var ListingId: String?
        var ListAgentName: String?
        var ListAgentStateLicense: String?
        var ListAgentEmail: String?
        var CoListAgentName: String?
        var MlsStatus: String?
        var ListOfficePhone: String?
        var ListOfficeFax: String?
        
        var UnparsedFirstLineAddress: String?
        var City: String?
        var PostalCode: String?
        var StateOrProvince: String?
        
        var UnparsedAddress: String?
        
        var CurrentPricePublic: Int?
        var ListPrice: Int?
        var PublicRemarks: String?
        
        var ListAgentURL: String?
        var ListOfficeName: String?
        
        var VirtualTours: [VirtualToursObjs]?
        struct VirtualToursObjs: Codable {
            var Uri: String?
        }
        var Videos: [VideosObjs]?
        struct VideosObjs: Codable {
            var ObjectHtml: String?
        }

        
        var Photos: [PhotoDictionary]?
        struct PhotoDictionary:Codable {
            var Id: String
            var Name: String
            var Uri640: String
            var Uri800: String
            var Uri1600: String
            
        }

        
        
        init(BathsFull: String? = nil, Latitude: Double? = nil, Longitude: Double? = nil, BedsTotal: String? = nil, ListingId: String? = nil, BuildingAreaTotal:Float? = nil,ListAgentName: String? = nil, CoListAgentName: String? = nil, MlsStatus: String? = nil, ListOfficePhone: String? = nil, UnparsedFirstLineAddress: String? = nil, City: String? = nil, PostalCode: String?, StateOrProvince: String? = nil, UnparsedAddress: String? = nil, CurrentPricePublic: Int? = nil, ListPrice: Int? = nil, PublicRemarks: String? = nil, Photos:[PhotoDictionary]? = nil, Videos:[VideosObjs]? = nil, VirtualTours:[VirtualToursObjs]? = nil)
        {
            self.BathsFull = BathsFull ?? ""
            self.BedsTotal = BedsTotal ?? ""
            self.ListingId = ListingId ?? ""
            self.BuildingAreaTotal = BuildingAreaTotal ?? nil
            self.Latitude = Latitude ?? 0
            self.Longitude = Longitude ?? 0
            self.ListAgentName = ListAgentName ?? ""
            self.CoListAgentName = CoListAgentName ?? ""
            self.MlsStatus = MlsStatus ?? ""
            self.ListOfficePhone = ListOfficePhone ?? ""
            self.UnparsedFirstLineAddress = UnparsedFirstLineAddress ?? ""
            self.City = City ?? ""
            self.PostalCode = PostalCode ?? ""
            self.StateOrProvince = StateOrProvince ?? ""
            self.UnparsedAddress = UnparsedAddress ?? ""
            self.CurrentPricePublic = CurrentPricePublic ?? 0
            self.ListPrice = ListPrice ?? 0
            self.PublicRemarks = PublicRemarks ?? ""
            self.Photos = Photos ?? []
            self.Videos = Videos ?? []
            self.VirtualTours = VirtualTours ?? []
        
            
        }
        private enum CodingKeys: String, CodingKey {
            case BathsFull = "BathsFull", BedsTotal = "BedsTotal", Latitude = "Latitude", Longitude = "Longitude", ListingId = "ListingId", BuildingAreaTotal = "BuildingAreaTotal", ListAgentName = "ListAgentName", CoListAgentName = "CoListAgentName", MlsStatus = "MlsStatus", ListOfficePhone = "ListOfficePhone", UnparsedFirstLineAddress = "UnparsedFirstLineAddress", City = "City", PostalCode = "PostalCode", StateOrProvince = "StateOrProvince", UnparsedAddress = "UnparsedAddress", CurrentPricePublic = "CurrentPricePublic", ListPrice = "ListPrice", PublicRemarks = "PublicRemarks", Photos = "Photos", Videos = "Videos", VirtualTours = "VirtualTours"

        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            Latitude = try container.decode(Double.self, forKey: .Latitude)
            Longitude = try container.decode(Double.self, forKey: .Longitude)
            ListingId = try container.decode(String.self, forKey: .ListingId)
            ListAgentName = try container.decode(String.self, forKey: .ListAgentName)
            MlsStatus = try container.decode(String.self, forKey: .MlsStatus)
            ListOfficePhone = try container.decodeIfPresent(String.self, forKey: .ListOfficePhone)
            UnparsedFirstLineAddress = try container.decodeIfPresent(String.self, forKey: .UnparsedFirstLineAddress)
            City = try container.decodeIfPresent(String.self, forKey: .City)
            PostalCode = try container.decodeIfPresent(String.self, forKey: .PostalCode)
            StateOrProvince = try container.decodeIfPresent(String.self, forKey: .StateOrProvince)
            UnparsedAddress = try container.decodeIfPresent(String.self, forKey: .UnparsedAddress)
            CurrentPricePublic = try container.decodeIfPresent(Int.self, forKey: .CurrentPricePublic)
            ListPrice = try container.decodeIfPresent(Int.self, forKey: .ListPrice)
            PublicRemarks = try container.decodeIfPresent(String.self, forKey: .PublicRemarks)
            Photos = try container.decodeIfPresent([PhotoDictionary].self, forKey: .Photos)
            Videos = try container.decodeIfPresent([VideosObjs].self, forKey: .Videos)
            VirtualTours = try container.decodeIfPresent([VirtualToursObjs].self, forKey: .VirtualTours)

            if let value = try? container.decode(Int.self, forKey: .BathsFull) {
                BathsFull = String(value)
            } else {
                BathsFull = try container.decode(String.self, forKey: .BathsFull)
            }

            if let value = try? container.decode(Int.self, forKey: .BedsTotal) {
                BedsTotal = String(value)
            } else {
                BedsTotal = try container.decode(String.self, forKey: .BedsTotal)
            }
            
            if let value = try? container.decode(String.self, forKey: .BuildingAreaTotal) {
                BuildingAreaTotal = Float(value)
            } else {
                BuildingAreaTotal = try? container.decode(Float.self, forKey: .BuildingAreaTotal)
            }
            
            if let value = try? container.decodeIfPresent(String.self, forKey: .CoListAgentName) {
                CoListAgentName = String(value)
            } else {
                CoListAgentName = nil
            }
            
        }
    }
    
    
    //    var session:Session!
    static func fetchListing(_ completionHandler: @escaping (listingData) -> ())  {
        
        let baseUrl = URL(string: "https://sparkapi.com/v1/session?ApiKey=vc_c15909466_key_1&ApiSig=a2b8a9251df6e00bf32dd16402beda91")!
        let request = NSMutableURLRequest(url: baseUrl)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let data = data else { return }
            
            if let error = error {
                print(error)
            }
            
            do {
                let listing = try? JSONDecoder().decode(ActiveListings.responseData.self, from: data)
//                let products = throwables.compactMap { try? $0.result.get() }
 
                let authToken = listing!.D.Results[0].AuthToken
                //String to Hash //nicki ane karen 20160917171150811658000000 jord 20160917171113923841000000
                
                // MARK: - Begin Sherwood
                let agentSherwood = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'_orderby-ListPrice_pagination1"
                
                let SherwoodHighToLow = md5(sessionHash: agentSherwood)
//                /v1/my/listings?ApiSig=\(apisig)&AuthToken=\(apitok)&_limit=10&_pagination=1

                let sherwoodhl = "http://sparkapi.com/v1/my/listings?ApiSig=\(SherwoodHighToLow)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'&_orderby=-ListPrice&_pagination=1"
                
                guard let newSherwoodUrl = sherwoodhl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }

                
                                let nextReqHash = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'_orderby-ListPrice_pagination1_page2"
                                
                                let nextReq = md5(sessionHash: nextReqHash)
                //                /v1/my/listings?ApiSig=\(apisig)&AuthToken=\(apitok)&_limit=10&_pagination=1

                                let nextUrl = "http://sparkapi.com/v1/my/listings?ApiSig=\(nextReq)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'&_orderby=-ListPrice&_pagination=1&_page=2"
                                
                                guard let newNextUrl = nextUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
                                print(newNextUrl)
            
                // MARK: - Begin Nicki Karen
            //uncomment to use in production
        //             let agentNickiKarenAvailableStringHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filter(ListAgentId Eq '\(NICKIKARENID)' Or CoListAgentId Eq '\(NICKIKARENID)') And (MlsStatus Eq 'Active' Or MlsStatus Eq 'Active Under Contract')_limit20_orderby-ListPrice_pagination1"
                //uncomment to use in production
//                let NKAvailableStringHighToLowSig = md5(sessionHash: agentNickiKarenAvailableStringHighToLow)
                //uncomment to use in production
               // let nickiKarenAvailableHighToLow = "http://sparkapi.com/v1/listings?ApiSig=\(NKAvailableStringHighToLowSig)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=(ListAgentId Eq '\(NICKIKARENID)' Or CoListAgentId Eq '\(NICKIKARENID)') And (MlsStatus Eq 'Active' Or MlsStatus Eq 'Active Under Contract')&_limit=20&_orderby=-ListPrice&_pagination=1"
                
                // uncomment guard to use in production
                // guard let newNickiKarenUrl = nickiKarenAvailableHighToLow.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
                // MARK: end Nicki Karen //
                
                
                // MARK: Begin Jordan Available Listings
               //uncomment to use in production
                // let agentJordanAvailableStringHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filter(ListAgentId Eq '\(JORDAN_ID)' Or CoListAgentId Eq '\(JORDAN_ID)') And (MlsStatus Eq 'Active' Or MlsStatus Eq 'Active Under Contract')_limit10_orderby-ListPrice_pagination1"
                
                // Hash Here
                //uncomment to use in production
                //let JordanagentAvailableStringHighToLowSig = md5(sessionHash: agentJordanAvailableStringHighToLow)
                
                //Concantenated query
                //uncomment to use in production
               // let JordanavailableHighToLow = "http://sparkapi.com/v1/listings?ApiSig=\(JordanagentAvailableStringHighToLowSig)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=(ListAgentId Eq '\(JORDAN_ID)' Or CoListAgentId Eq '\(JORDAN_ID)') And (MlsStatus Eq 'Active' Or MlsStatus Eq 'Active Under Contract')&_limit=10&_orderby=-ListPrice&_pagination=1"
                
               // uncomment to use in production
               // guard let newUrl = JordanavailableHighToLow.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
                // // MARK: End Jordan Available Listings
                
                let newCallUrl = URL(string:newSherwoodUrl)
                let nextNewCall = URL(string: newNextUrl)
                //                    let newCallUrl = URL(string:newNickiKarenUrl)
                
                var request = URLRequest(url: newCallUrl!)
                print(request)
                    var nextRequest = URLRequest(url: nextNewCall!)
                print(nextRequest)
                request.httpMethod = "GET"
                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
                request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
                
                let newTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                    guard let data = data else { return }
                    if let error = error {
                        print(error)
                    }
                    do {
                        //call to get photos
//                        let throwables = try JSONDecoder().decode(Throwable<listingResults>.self, from: data)
////                        let products = throwables.compactMap { $0.value }
//                        print(throwables)

                    let newListing = try JSONDecoder().decode(listingData.self, from: data)
                        print(newListing.D.Results)
                        
                        
  //                      let dictionary = try! JSONDecoder().decode(AllListings.standardFields.self, from: data)
//                        print(dictionary)
                        
                        var photosArray = [String]()
                        let theListing = newListing.D.Results
                        for aListing in (theListing) {
                            for aPhoto in aListing.StandardFields.Photos ?? [] {
                                photosArray.append(aPhoto.Uri800)
                            }
//                            photosArray.removeAll()
                        }
                        
                         DispatchQueue.main.async(execute: { () -> Void in
                            completionHandler(newListing)
                                })
                    } catch let err {

                        print(err)
                    }
                }
                newTask.resume()
            } 
        }
        task.resume()
    }
}


