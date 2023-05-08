//
//  SoldListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
struct SoldListings: Codable {
    
    static let shared = SoldListings()
    
    struct responseData: Codable {
        var D: ResultsData
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
    struct resultsArr: Codable {
        var AuthToken: String
        var Expires: String
    }
    //listing struct
    struct listingData: Codable {
        var D: listingResultsData
    }
    struct listingResultsData: Codable {
        var Results: [listingResults]
        
    }
    // Pagination?
    //    struct newPagination: Codable {
    //           var TotalRows: Int
    //           var PageSize: Int
    //           var CurrentPage: Int
    //           var TotalPages: Int
    //    }
    struct listingResults: Codable {
        var Id: String
        var ResourceUri: String
        var StandardFields: standardFields
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
        
        var Documents: [DocumentsAvailable]?
        struct DocumentsAvailable: Codable {
            var Id: String
            var ResourceId: String
            var Name: String
        }
        var Photos: [PhotoDictionary]?
        struct PhotoDictionary:Codable {
            var Id: String
            var Name: String
            var Uri640: String
            var Uri800: String
            var Uri1600: String
            
        }
        
        
        
        init(BathsFull: String? = nil, Latitude: Double? = nil, Longitude: Double? = nil, BedsTotal: String? = nil, ListingId: String? = nil, BuildingAreaTotal:Float? = nil,ListAgentName: String? = nil, CoListAgentName: String? = nil, MlsStatus: String? = nil, ListOfficePhone: String? = nil, UnparsedFirstLineAddress: String? = nil, City: String? = nil, PostalCode: String? = nil, StateOrProvince: String? = nil, UnparsedAddress: String? = nil, CurrentPricePublic: Int? = nil, ListPrice: Int? = nil, PublicRemarks: String? = nil, Photos:[PhotoDictionary]? = nil,Videos:[VideosObjs]? = nil, VirtualTours:[VirtualToursObjs]? = nil)
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
            self.Documents = Documents ?? []
            
        }
        private enum CodingKeys: String, CodingKey {
            case BathsFull = "BathsFull", BedsTotal = "BedsTotal", Latitude = "Latitude", Longitude = "Longitude", ListingId = "ListingId", BuildingAreaTotal = "BuildingAreaTotal", ListAgentName = "ListAgentName", CoListAgentName = "CoListAgentName", MlsStatus = "MlsStatus", ListOfficePhone = "ListOfficePhone", UnparsedFirstLineAddress = "UnparsedFirstLineAddress", City = "City", PostalCode = "PostalCode", StateOrProvince = "StateOrProvince", UnparsedAddress = "UnparsedAddress", CurrentPricePublic = "CurrentPricePublic", ListPrice = "ListPrice", PublicRemarks = "PublicRemarks", Photos = "Photos", Videos = "Videos", VirtualTours = "VirtualTours", Documents = "Documents"
            
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
            Documents = try container.decodeIfPresent([DocumentsAvailable].self, forKey: .Documents)
            
            
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
        let ud:String = UserDefaults.standard.object(forKey: "AuthToken") as! String
        // MARK: - Begin Sherwood
        let agentSherwood = "\(MY_LISTINGS_SERVICE)\(ud)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Closed'_limit25_orderby-ListPrice_pagination1_skipToken10"
        
        let SherwoodHighToLow = md5(sessionHash: agentSherwood)
        
        let sherwoodhl = "http://sparkapi.com/v1/my/listings?ApiSig=\(SherwoodHighToLow)&AuthToken=\(ud)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Closed'&_limit=25&_orderby=-ListPrice&_pagination=1&_skipToken=10"
        
        
        guard let newSherwoodUrl = sherwoodhl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        //                    print(newNextUrl)
        
        // MARK: - Begin Nicki and Karen Sold
        //uncomment to use in prodction
        //                    let agentNKAvailableStringHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Closed' And PropertyClass Ne 'Rental' And CoListAgentId Ne NULL And ListAgentId Eq '20160917171150811658000000'_limit20_orderby-ListPrice_pagination1"
        //
        //                    let NKHashSold = md5(sessionHash: agentNKAvailableStringHighToLow)
        //
        //                    let nickkaren = "http://sparkapi.com/v1/listings?ApiSig=\(NKHashSold)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Closed' And PropertyClass Ne 'Rental' And CoListAgentId Ne NULL And ListAgentId Eq '20160917171150811658000000'&_limit=20&_orderby=-ListPrice&_pagination=1"
        //
        //                    guard let nickikarenSoldUrl = nickkaren.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        /// End Nicki Karen Strikng
        
        
        // MARK: - Jordan  String
        //uncomment to use in production
        //                    let agentJordanAvailableStringHighToLow = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Sold' And MlsStatus Ne 'Active Under Contract' And CoListAgentId Eq NULL And ListAgentId Eq '\(JORDAN_ID)'_limit20_orderby-ListPrice_pagination1"
        //
        //                    let jordanHashSold = md5(sessionHash: agentJordanAvailableStringHighToLow)
        //
        //                    let jordan = "\(GET_URL)listings?ApiSig=\(jordanHashSold)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Sold' And MlsStatus Ne 'Active Under Contract' And CoListAgentId Eq NULL And ListAgentId Eq '\(JORDAN_ID)'&_limit=20&_orderby=-ListPrice&_pagination=1"
        //
        //                    guard let jordanSoldUrl = jordan.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        // MARK: end Jordan String
        
        
        // MARK: Place guard let here:
        let newCallUrl = URL(string: newSherwoodUrl)
        
        var request = URLRequest(url: newCallUrl!)
        
        print(request)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let newTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error)
            }
            do {
                //call to get photos
                let newListing = try JSONDecoder().decode(listingData.self, from: data)
                
                //                            let currentPage = newListing.D.Pagination?.CurrentPage
                //                            let skipToken = 10
                //
                //                            let agentSherwoodNext = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(authToken)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Closed'_limit10_pagination1_skiptoken10_page2"
                //                            let HashNext = md5(sessionHash: agentSherwoodNext)
                //                            let agentNextCall = "http://sparkapi.com/v1/my/listings?ApiSig=\(HashNext)&AuthToken=\(authToken)&_page=2&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Closed'&_limit=10&_pagination=1&_skiptoken=10&page=2"
                //                            guard let nextCall = agentNextCall.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
                //                            print(nextCall)
                
                //                            let NewNextHash = md5(sessionHash: nextPageHash)
                //                            let nextPageLink = "http://sparkapi.com/v1/my/listings?ApiSig=\(NewNextHash)&AuthToken=\(authToken)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Closed'&_limit=10&&_pagination=1"
                //                            guard let newNextUrl = nextPageLink.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
                //                            let nextCallUrl = URL(string: nextCall)
                //                            print(nextCallUrl)
                
                var photosArray = [String]()
                let theListing = newListing.D.Results
                for aListing in (theListing) {
                    for aPhoto in aListing.StandardFields.Photos ?? [] {
                        photosArray.append(aPhoto.Uri1600)
                    }
                    photosArray.removeAll()
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


