//
//  CustomFields.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/7/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import Foundation

//// MARK: - Session
struct SessionCustom: Codable {
    var d: D

    enum CodingKeys: String, CodingKey {
        case d
    }
}

// MARK: - D
struct D: Codable {
    var results: [Results]
    var success: Bool

    enum CodingKeys: String, CodingKey {
        case results
        case success
    }
}

// MARK: - Result
struct Results: Codable {
    var id: String
    var resourceURI: String
    var standardFields: [String: StandardField]
    var customFields: [CustomField]
    var lastCachedTimestamp: JSONNull?
    var displayCompliance: DisplayCompliance

    enum CodingKeys: String, CodingKey {
        case id
        case resourceURI
        case standardFields
        case customFields
        case lastCachedTimestamp
        case displayCompliance
    }
}

// MARK: - CustomField
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

// MARK: - Appliance
struct Appliance: Codable {
    var centralVacuum: Bool

    enum CodingKeys: String, CodingKey {
        case centralVacuum
    }
}

// MARK: - AssociationAmenity
struct AssociationAmenity: Codable {
    var gatedCommunity3: Bool?
    var guardGatedComm: Bool?

    enum CodingKeys: String, CodingKey {
        case gatedCommunity3
        case guardGatedComm
    }
}

// MARK: - AssociationPetRule
struct AssociationPetRule: Codable {
    var assocPetRules: Bool?
    var callForRules: Bool?

    enum CodingKeys: String, CodingKey {
        case assocPetRules
        case callForRules
    }
}

// MARK: - BathroomFeature
struct BathroomFeature: Codable {
    var marbleShower: Bool?
    var steamShower: Bool?

    enum CodingKeys: String, CodingKey {
        case marbleShower
        case steamShower
    }
}

// MARK: - BedroomFeature
struct BedroomFeature: Codable {
    var mainFloorMaster: Bool

    enum CodingKeys: String, CodingKey {
        case mainFloorMaster
    }
}

// MARK: - BuildersInformation
struct BuildersInformation: Codable {
    var builderSName: String?
    var builderSModelName: String?

    enum CodingKeys: String, CodingKey {
        case builderSName
        case builderSModelName
    }
}

// MARK: - BuildingStyle
struct BuildingStyle: Codable {
    var cottage: Bool

    enum CodingKeys: String, CodingKey {
        case cottage
    }
}

// MARK: - CommunityFeature
struct CommunityFeature: Codable {
    var golfCourseInDevelopment: Bool

    enum CodingKeys: String, CodingKey {
        case golfCourseInDevelopment
    }
}

// MARK: - CookingAppliance
struct CookingAppliance: Codable {
    var builtIns: Bool?
    var microwave: Bool?

    enum CodingKeys: String, CodingKey {
        case builtIns
        case microwave
    }
}

// MARK: - CoolingType
struct CoolingType: Codable {
    var centralAC: Bool

    enum CodingKeys: String, CodingKey {
        case centralAC
    }
}

// MARK: - Disclosure
struct Disclosure: Codable {
    var ccR: Bool?
    var homeWarrantyPlan: Bool?
    var plannedDevelopment: Bool?
    var soilsReport: Bool?

    enum CodingKeys: String, CodingKey {
        case ccR
        case homeWarrantyPlan
        case plannedDevelopment
        case soilsReport
    }
}

// MARK: - EatingArea
struct EatingArea: Codable {
    var diningArea: Bool?
    var formalDiningRoom: Bool?
    var kitchenIsland: Bool?

    enum CodingKeys: String, CodingKey {
        case diningArea
        case formalDiningRoom
        case kitchenIsland
    }
}

// MARK: - EntryLocation
struct EntryLocation: Codable {
    var mainLevel: Bool

    enum CodingKeys: String, CodingKey {
        case mainLevel
    }
}

// MARK: - ExteriorConstruction
struct ExteriorConstruction: Codable {
    var siding: Bool?
    var stone: Bool?

    enum CodingKeys: String, CodingKey {
        case siding
        case stone
    }
}

// MARK: - Fencing
struct Fencing: Codable {
    var wroughtIron: Bool

    enum CodingKeys: String, CodingKey {
        case wroughtIron
    }
}

// MARK: - Flooring
struct Flooring: Codable {
    var carpet: Bool?
    var hardwood: Bool?
    var marble: Bool?
    var stone2: Bool?

    enum CodingKeys: String, CodingKey {
        case carpet
        case hardwood
        case marble
        case stone2
    }
}

// MARK: - Foundation
struct Foundation: Codable {
    var concreteSlab: Bool

    enum CodingKeys: String, CodingKey {
        case concreteSlab
    }
}

// MARK: - FrontOfHouseFace
struct FrontOfHouseFace: Codable {
    var houseFacesEast: Bool

    enum CodingKeys: String, CodingKey {
        case houseFacesEast
    }
}

// MARK: - GeneralPropertyInformation
struct GeneralPropertyInformation: Codable {
    var bedrooms: Int?
    var lotAcres2: Double?
    var bathsFull: Int?
    var baths34: Int?
    var baths12: Int?
    var baths14: Int?
    var approxSqFt: Int?
    var bathsTotal: Int?
    var lotSqFt: Int?
    var zoning2: String?
    var yearBuilt2: Int?
    var constructionStatus: String?
    var commonWalls: String?

    enum CodingKeys: String, CodingKey {
        case bedrooms
        case lotAcres2
        case bathsFull
        case baths34
        case baths12
        case baths14
        case approxSqFt
        case bathsTotal
        case lotSqFt
        case zoning2
        case yearBuilt2
        case constructionStatus
        case commonWalls
    }
}

// MARK: - GreenEnergyEfficient
struct GreenEnergyEfficient: Codable {
    var insulation: Bool

    enum CodingKeys: String, CodingKey {
        case insulation
    }
}

// MARK: - HeatingType
struct HeatingType: Codable {
    var centralFurnace: Bool

    enum CodingKeys: String, CodingKey {
        case centralFurnace
    }
}

// MARK: - HOA1Frequency
struct HOA1Frequency: Codable {
    var monthly2: Bool

    enum CodingKeys: String, CodingKey {
        case monthly2
    }
}

// MARK: - HOAInformation
struct HOAInformation: Codable {
    var hoa: String?
    var hoaFee1: Double?

    enum CodingKeys: String, CodingKey {
        case hoa
        case hoaFee1
    }
}

// MARK: - InteriorFeature
struct InteriorFeature: Codable {
    var the220VThroughout: Bool?
    var builtIns2: Bool?

    enum CodingKeys: String, CodingKey {
        case the220VThroughout
        case builtIns2
    }
}

// MARK: - KitchenFeature
struct KitchenFeature: Codable {
    var gourmetKitchen: Bool

    enum CodingKeys: String, CodingKey {
        case gourmetKitchen
    }
}

// MARK: - LandLeaseType
struct LandLeaseType: Codable {
    var feeSimple: Bool

    enum CodingKeys: String, CodingKey {
        case feeSimple
    }
}

// MARK: - LaundryLocation
struct LaundryLocation: Codable {
    var individualRoom: Bool

    enum CodingKeys: String, CodingKey {
        case individualRoom
    }
}

// MARK: - Level
struct Level: Codable {
    var two: Bool

    enum CodingKeys: String, CodingKey {
        case two
    }
}

// MARK: - ListingInfo
struct ListingInfo: Codable {
    var signOnProperty: String

    enum CodingKeys: String, CodingKey {
        case signOnProperty
    }
}

// MARK: - ListingLocationAndPropertyInfo
struct ListingLocationAndPropertyInfo: Codable {
    var entryDate: String?
    var listingPrice: Int?
    var listPriceSqFt: Double?
    var propertySubType: String?
    var street: String?
    var streetName2: String?
    var suffix: String?
    var county2: String?
    var city2: String?
    var stateProvince2: String?
    var zipCode: String?
    var apnTaxID: String?
    var masterArea: String?
    var area2: String?
    var subdivisionTractCode: String?
    var country2: String?

    enum CodingKeys: String, CodingKey {
        case entryDate
        case listingPrice
        case listPriceSqFt
        case propertySubType
        case street
        case streetName2
        case suffix
        case county2
        case city2
        case stateProvince2
        case zipCode
        case apnTaxID
        case masterArea
        case area2
        case subdivisionTractCode
        case country2
    }
}

// MARK: - LotDescription
struct LotDescription: Codable {
    var lotShapeRectangle: Bool

    enum CodingKeys: String, CodingKey {
        case lotShapeRectangle
    }
}

// MARK: - LotLocation
struct LotLocation: Codable {
    var culDeSac: Bool?
    var onGolfCourse: Bool?

    enum CodingKeys: String, CodingKey {
        case culDeSac
        case onGolfCourse
    }
}

// MARK: - ParkingFeature
struct ParkingFeature: Codable {
    var privateGarage: Bool

    enum CodingKeys: String, CodingKey {
        case privateGarage
    }
}

// MARK: - ParkingSpacesInformation
struct ParkingSpacesInformation: Codable {
    var totalGarageSpaces: Int

    enum CodingKeys: String, CodingKey {
        case totalGarageSpaces
    }
}

// MARK: - ParkingType
struct ParkingType: Codable {
    var garage3Doors: Bool

    enum CodingKeys: String, CodingKey {
        case garage3Doors
    }
}

// MARK: - PatioFeature
struct PatioFeature: Codable {
    var covered: Bool

    enum CodingKeys: String, CodingKey {
        case covered
    }
}

// MARK: - Possession
struct Possession: Codable {
    var closeOfEscrow: Bool

    enum CodingKeys: String, CodingKey {
        case closeOfEscrow
    }
}

// MARK: - PropertyCondition
struct PropertyCondition: Codable {
    var underConstruction: Bool

    enum CodingKeys: String, CodingKey {
        case underConstruction
    }
}

// MARK: - PropertyInfo
struct PropertyInfo: Codable {
    var view: String?
    var dwellingTotalFloors: Int?
    var pool: String?
    var spa: String?
    var fireplace: String?

    enum CodingKeys: String, CodingKey {
        case view
        case dwellingTotalFloors
        case pool
        case spa
        case fireplace
    }
}

// MARK: - RemarksMisc
struct RemarksMisc: Codable {
    var marketingRemarks: String

    enum CodingKeys: String, CodingKey {
        case marketingRemarks
    }
}

// MARK: - Roofing
struct Roofing: Codable {
    var concreteTile: Bool

    enum CodingKeys: String, CodingKey {
        case concreteTile
    }
}

// MARK: - Room
struct Room: Codable {
    var bonusRoom2: Bool?
    var denOffice: Bool?
    var diningRoom: Bool?
    var greatRoom2: Bool?
    var library2: Bool?
    var retreat: Bool?

    enum CodingKeys: String, CodingKey {
        case bonusRoom2
        case denOffice
        case diningRoom
        case greatRoom2
        case library2
        case retreat
    }
}

// MARK: - School
struct School: Codable {
    var lElementary: String?
    var lMiddle: String?
    var lHighSchool: String?

    enum CodingKeys: String, CodingKey {
        case lElementary
        case lMiddle
        case lHighSchool
    }
}

// MARK: - SecuritySafety
struct SecuritySafety: Codable {
    var gatedCommWGrd: Bool?
    var gatedCommunity2: Bool?

    enum CodingKeys: String, CodingKey {
        case gatedCommWGrd
        case gatedCommunity2
    }
}

// MARK: - Sewer
struct Sewer: Codable {
    var inStreet: Bool

    enum CodingKeys: String, CodingKey {
        case inStreet
    }
}

// MARK: - SpecialCondition
struct SpecialCondition: Codable {
    var standard: Bool

    enum CodingKeys: String, CodingKey {
        case standard
    }
}

// MARK: - Sprinkler
struct Sprinkler: Codable {
    var sprinklerSystem: Bool

    enum CodingKeys: String, CodingKey {
        case sprinklerSystem
    }
}

// MARK: - StatusChangeInfo
struct StatusChangeInfo: Codable {
    var status3: String

    enum CodingKeys: String, CodingKey {
        case status3
    }
}

// MARK: - Term
struct Term: Codable {
    var cashToNewLoan: Bool

    enum CodingKeys: String, CodingKey {
        case cashToNewLoan
    }
}

// MARK: - TVService
struct TVService: Codable {
    var cableTV2: Bool

    enum CodingKeys: String, CodingKey {
        case cableTV2
    }
}

// MARK: - ViewType
struct ViewType: Codable {
    var golfCourseView: Bool?
    var mountainView: Bool?

    enum CodingKeys: String, CodingKey {
        case golfCourseView
        case mountainView
    }
}

// MARK: - Water
struct Water: Codable {
    var inStreet2: Bool

    enum CodingKeys: String, CodingKey {
        case inStreet2
    }
}

// MARK: - WaterHeaterFeature
struct WaterHeaterFeature: Codable {
    var tankless: Bool

    enum CodingKeys: String, CodingKey {
        case tankless
    }
}

// MARK: - Window
struct Window: Codable {
    var doublePaneWindows: Bool

    enum CodingKeys: String, CodingKey {
        case doublePaneWindows
    }
}

// MARK: - DisplayCompliance
struct DisplayCompliance: Codable {
    var view: String
    var idxLogo: IdxLogo
    var idxLogoSmall: IdxLogo

    enum CodingKeys: String, CodingKey {
        case view
        case idxLogo
        case idxLogoSmall
    }
}

// MARK: - IdxLogo
struct IdxLogo: Codable {
    var type: String
    var logoURI: String

    enum CodingKeys: String, CodingKey {
        case type
        case logoURI
    }
}

enum StandardField: Codable {
    case anythingArray([JSONAny])
    case bool(Bool)
    case boolMap([String: Bool])
    case double(Double)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode([String: Bool].self) {
            self = .boolMap(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StandardField.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StandardField"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .bool(let x):
            try container.encode(x)
        case .boolMap(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
