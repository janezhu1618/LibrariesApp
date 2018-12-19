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


struct BrooklynLibraryFormatter {
    static func formatPhoneNumber(phone: String) -> String {
        return "Phone: " + phone.replacingOccurrences(of: ".", with: "-")
    }
    
    static func formatHoursOfOperation(mon: String, tue: String, wed: String, thurs: String, fri: String, sat: String, sun: String) -> String {
        let arrOfDays = [mon, tue, wed, thurs, fri, sat, sun]
        var updatedArr: [String] = []
        for day in arrOfDays {
            if day != "" {
            updatedArr.append(day.replacingOccurrences(of: "\n", with: ""))
            } else {
                updatedArr.append("Closed - Closed")
            }
        }
        return "Monday: \(updatedArr[0])\nTuesday: \(updatedArr[1])\nWednesday: \(updatedArr[2])\nThursday: \(updatedArr[3])\nFriday: \(updatedArr[4])\nSaturday: \(updatedArr[5])\nSunday: \(updatedArr[6])"
    }

}
