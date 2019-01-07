//
//  Favorites.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/7/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let name: String?
    let title: String?
    let address: String
    let city: String?
    let postcode: String?
    let phone: String
}
