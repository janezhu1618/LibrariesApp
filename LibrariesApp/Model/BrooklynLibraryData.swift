//
//  BrooklynLibraryData.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/14/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import Foundation

struct BrooklynLibrary: Codable {
    let locations: [BPLLocationsWrap]
}

struct BPLLocationsWrap: Codable {
    let data: BPLDataWrap
}

struct BPLDataWrap: Codable {
    let title: String
    let address: String
    let phone: String
    let Monday: String
    let Tuesday: String
    let Wednesday: String
    let Thursday: String
    let Friday: String
    let Saturday: String
    let Sunday: String
}
