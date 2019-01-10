//
//  NYPLData.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import Foundation

struct NYPL: Codable {
    let name: String
    let housenum: String?
    let streetname: String
    let zip: String
    let system: String
    let the_geom: CoordinatesWrap
    let url: String
    let city: String
}

struct CoordinatesWrap: Codable {
    let coordinates: [Double]
}

struct NYPLFormatter {
    static func formatCompleteAddress(houseNum: String?, street: String, city: String, zip: String) -> String {
        return "\(houseNum ?? "") \(street), \(city), NY \(zip)"
    }
}
