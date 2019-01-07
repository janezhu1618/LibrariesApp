//
//  AppError.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/7/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import Foundation

enum AppError {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
}
