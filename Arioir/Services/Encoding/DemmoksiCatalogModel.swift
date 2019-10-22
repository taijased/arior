//
//  DemmoksiCatalogModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import Foundation
import XMLCoder


struct YmlCatalog: Codable {
    var shop: Shop
}

struct Shop: Codable {
    var name: String
    var company: String
    var url: String
    var categories: Categories
    var offers: Offers
}


struct Categories: Codable, Equatable, DynamicNodeEncoding {

    let categories: [Category]

    private enum CodingKeys: String, CodingKey {
        case categories = "category"
    }

    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
            default: return .element
        }
    }
}


struct Category: Codable, Equatable, DynamicNodeEncoding {
    let id: String
    let value: String

    private enum CodingKeys: String, CodingKey {
        case id
        case value = ""
    }

    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case Category.CodingKeys.id:
            return .attribute
        default:
            return .element
        }
    }
}




struct Offers: Codable, Equatable, DynamicNodeEncoding {
    let offers: [Offer]

    private enum CodingKeys: String, CodingKey {
        case offers = "offer"
    }

    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
            default: return .element
        }
    }
}

struct Offer: Codable, Equatable, DynamicNodeEncoding {

    let id: String
    let available: Bool
    let price: String?
    let oldprice: String?
    let currencyId: String?
    let categoryId: String?
    let picture: String?
    let vendor: String?
    let vendorCode: String?
    let name: String?
    let description: String?
    let sales_notes: String?
    let country_of_origin: String?
    let params: [Param]?

    private enum CodingKeys: String, CodingKey {
        case id
        case available
        case price
        case oldprice
        case currencyId
        case categoryId
        case picture
        case vendor
        case vendorCode
        case name
        case description
        case sales_notes
        case country_of_origin
        case params = "param"
    }

    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
            case Offer.CodingKeys.id:
                return .attribute
            case Offer.CodingKeys.available:
                return .attribute
            default:
                return .element
        }
    }
}

struct Param: Codable, Equatable, DynamicNodeEncoding {
    let name: String
    let value: String?

    private enum CodingKeys: String, CodingKey {
        case name
        case value
    }

    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case Param.CodingKeys.name:
            return .attribute
        default:
            return .element
        }
    }
}
