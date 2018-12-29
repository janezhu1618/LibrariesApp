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
    static func formatCompleteAddress(streetAddress: String, borough: String, postcode: String) -> String {
        return "\(streetAddress), \(borough), NY \(postcode)"
    }
    
    static func formatHoursOfOperation(mon: String, tue: String, wed: String, thurs: String, fri: String, sat: String, sun: String) -> String {
        return "Monday: \(mon) \nTuesday: \(tue) \nWednesday: \(wed) \nThursday: \(thurs) \nFriday: \(fri) \nSaturday: \(sat) \nSunday: \(sun)"
    }
}
