//
//  ActiveListings.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/21/18.
//  Copyright © 2018 Alex Beattie. All rights reserved.
//

import UIKit
import Foundation
class ActiveListings: Codable {
    
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
    //    static let shared = Service() // singleton
    static func fetchAuthToken(completion: @escaping (responseData) -> ()) {
        var request = URLRequest(url: URL(string: "\(SESSION_URL)")!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        request.httpMethod = "POST"
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
        
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let json = data {
                do {
                    let tokenResponse = try JSONDecoder().decode(responseData.self, from: json)
                    //                    print(tokenResponse.D?.Results)
                    _ = tokenResponse.D.Results[0].AuthToken
                    //                    print("This is the authToken: \(authToken)")
                    
                    completion(tokenResponse)
                    
                    
                } catch {
                    print(error)
                }
            }
        }
        
        task.resume()
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
        var CustomFields: [CustomField]?
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
        
        
        
        init(BathsFull: String? = nil, Latitude: Double? = nil, Longitude: Double? = nil, BedsTotal: String? = nil, ListingId: String? = nil, BuildingAreaTotal:Float? = nil,ListAgentName: String? = nil, CoListAgentName: String? = nil, MlsStatus: String? = nil, ListOfficePhone: String? = nil, UnparsedFirstLineAddress: String? = nil, City: String? = nil, PostalCode: String? = nil, StateOrProvince: String? = nil, UnparsedAddress: String? = nil, CurrentPricePublic: Int? = nil, ListPrice: Int? = nil, PublicRemarks: String? = nil, Photos:[PhotoDictionary]? = nil, Videos:[VideosObjs]? = nil, VirtualTours:[VirtualToursObjs]? = nil, Documents:[DocumentsAvailable]? = nil)
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
    struct CustomField: Codable {
        var main: [Main]
        
        enum CodingKeys: String, CodingKey {
            case main
        }
    }
    
    // MARK: - Main
    struct Main: Codable {
        var listingLocationAndPropertyInfo: [ListingLocationAndPropertyInfo]
        var generalPropertyInformation: [GeneralPropertyInformation]?
        var remarksMisc: [RemarksMisc]?
        var listingInfo: [ListingInfo]?
        var propertyInfo: [PropertyInfo]?
        var statusChangeInfo: [StatusChangeInfo]?
        var landLeaseType: [LandLeaseType]?
        var specialConditions: [SpecialCondition]?
        var terms: [Term]?
        var bedroomFeatures: [BedroomFeature]?
        var possession: [Possession]?
        var buildersInformation: [BuildersInformation]?
        var lotDescription: [LotDescription]?
        var lotLocation: [LotLocation]?
        var schools: [School]?
        var viewType: [ViewType]?
        var frontOfHouseFaces: [FrontOfHouseFace]?
        var propertyCondition: [PropertyCondition]?
        var disclosures: [Disclosure]?
        var communityFeatures: [CommunityFeature]?
        var buildingStyle: [BuildingStyle]?
        var laundryLocations: [LaundryLocation]?
        var sprinklers: [Sprinkler]?
        var fencing: [Fencing]?
        var levels: [Level]?
        var entryLocation: [EntryLocation]?
        var appliances: [Appliance]?
        var cookingAppliances: [CookingAppliance]?
        var roofing: [Roofing]?
        var kitchenFeatures: [KitchenFeature]?
        var bathroomFeatures: [BathroomFeature]?
        var eatingAreas: [EatingArea]?
        var exteriorConstruction: [ExteriorConstruction]?
        var securitySafety: [SecuritySafety]?
        var foundation: [Foundation]?
        var flooring: [Flooring]?
        var coolingType: [CoolingType]?
        var sewer: [Sewer]?
        var water: [Water]?
        var heatingType: [HeatingType]?
        var hoaInformation: [HOAInformation]?
        var rooms: [Room]?
        var interiorFeatures: [InteriorFeature]?
        var tvServices: [TVService]?
        var windows: [Window]?
        var patioFeatures: [PatioFeature]?
        var waterHeaterFeature: [WaterHeaterFeature]?
        var greenEnergyEfficient: [GreenEnergyEfficient]?
        var parkingSpacesInformation: [ParkingSpacesInformation]?
        var parkingType: [ParkingType]?
        var parkingFeatures: [ParkingFeature]?
        var hoa1Frequency: [HOA1Frequency]?
        var associationAmenities: [AssociationAmenity]?
        var associationPetRules: [AssociationPetRule]?
        
        enum CodingKeys: String, CodingKey {
            case listingLocationAndPropertyInfo
            case generalPropertyInformation
            case remarksMisc
            case listingInfo
            case propertyInfo
            case statusChangeInfo
            case landLeaseType
            case specialConditions
            case terms
            case bedroomFeatures
            case possession
            case buildersInformation
            case lotDescription
            case lotLocation
            case schools
            case viewType
            case frontOfHouseFaces
            case propertyCondition
            case disclosures
            case communityFeatures
            case buildingStyle
            case laundryLocations
            case sprinklers
            case fencing
            case levels
            case entryLocation
            case appliances
            case cookingAppliances
            case roofing
            case kitchenFeatures
            case bathroomFeatures
            case eatingAreas
            case exteriorConstruction
            case securitySafety
            case foundation
            case flooring
            case coolingType
            case sewer
            case water
            case heatingType
            case hoaInformation
            case rooms
            case interiorFeatures
            case tvServices
            case windows
            case patioFeatures
            case waterHeaterFeature
            case greenEnergyEfficient
            case parkingSpacesInformation
            case parkingType
            case parkingFeatures
            case hoa1Frequency
            case associationAmenities
            case associationPetRules
        }
    }
    
    var emptyTok = ""
    static func fetchListing(_ completionHandler: @escaping (listingData) -> ())  {
        var emptyTok = ""
        fetchAuthToken { (response) in
            let newTok = response.D.Results
            for tok in newTok {
                emptyTok.append(tok.AuthToken)
                UserDefaults.standard.set(emptyTok, forKey: "AuthToken")
            }
            // MARK: - Begin Sherwood
            let agentSherwood = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(emptyTok)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'_orderby-ListPrice_pagination1"
            
            let SherwoodHighToLow = md5(sessionHash: agentSherwood)
            
            let sherwoodhl = "http://sparkapi.com/v1/my/listings?ApiSig=\(SherwoodHighToLow)&AuthToken=\(emptyTok)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'&_orderby=-ListPrice&_pagination=1"
            
            guard let newSherwoodUrl = sherwoodhl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }

            print("This is the Converted URL after session starts \(newSherwoodUrl)")
            
            // MARK: My weak attempt at pagination
            //                                let nextReqHash = "uTqE_dbyYSx6R1LvonsWOApiKeyvc_c15909466_key_1ServicePath/v1/my/listingsAuthToken\(emptyTok)_expandPhotos,Videos,VirtualTours,OpenHouses_filterMlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'_orderby-ListPrice_pagination1_page2"
            //
            //                                let nextReq = md5(sessionHash: nextReqHash)
            //                //                /v1/my/listings?ApiSig=\(apisig)&AuthToken=\(apitok)&_limit=10&_pagination=1
            //
            //                                let nextUrl = "http://sparkapi.com/v1/my/listings?ApiSig=\(nextReq)&AuthToken=\(emptyTok)&_expand=Photos,Videos,VirtualTours,OpenHouses&_filter=MlsStatus Eq 'Pending' Or MlsStatus Eq 'Active'&_orderby=-ListPrice&_pagination=1&_page=2"
            //
            //                                guard let newNextUrl = nextUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
            //                                print(newNextUrl)
            
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
            var request = URLRequest(url: newCallUrl!)
            
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
                    
                    let newListing = try JSONDecoder().decode(listingData.self, from: data)
                    
                    var photosArray = [String]()
                    let theListing = newListing.D.Results
                    for aListing in (theListing) {
                        for aPhoto in aListing.StandardFields.Photos ?? [] {
                            photosArray.append(aPhoto.Uri800)
                        }
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
}

