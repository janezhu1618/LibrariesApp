//
//  QueensLibraryData.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import Foundation

struct QueensLibrary: Codable {
    let name: String
    let address: String
    let city: String
    let postcode: String
    let phone: String
    let mn: String
    let tu: String
    let we: String
    let th: String
    let fr: String
    let sa: String
    let su: String
    let latitude: String?
    let longitude: String?
}


struct QueensLibraryFormatter {
    static func formatCompleteAddress(library: QueensLibrary) -> String {
        return "\(library.address), Queens, NY \(library.postcode)"
    }
    
    static func formatHoursOfOperation(library: QueensLibrary) -> String {
        return "Monday: \(library.mn) \nTuesday: \(library.tu) \nWednesday: \(library.we) \nThursday: \(library.th) \nFriday: \(library.fr) \nSaturday: \(library.sa) \nSunday: \(library.su)"
    }
}
