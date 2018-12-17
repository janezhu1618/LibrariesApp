//
//  DataSupport.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import Foundation

struct DataSupport {
    static func formatCompleteAddress(streetAddress: String, borough: String, postcode: String) -> String {
        return "Address: \n\(streetAddress) \n\(borough), New York \(postcode)"
    }
    
    static func formatHoursOfOperation(mon: String, tue: String, wed: String, thurs: String, fri: String, sat: String, sun: String) -> String {
        return "Hours of Operation: \nMonday: \(mon) \nTuesday: \(tue) \nWednesday: \(wed) \nThursday: \(thurs) \nFriday: \(fri) \nSaturday: \(sat) \nSunday: \(sun)"
    }
}
