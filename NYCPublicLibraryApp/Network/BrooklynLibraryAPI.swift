//
//  BrooklynLibraryAPI.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import Foundation

final class BrooklynLibraryAPI {
    static func getAllBranches(completionHandler: @escaping ([BPLLocationsWrap]?, AppError?) -> Void) {
        guard let myURL = URL.init(string: "https://www.bklynlibrary.org/locations/json") else {
            completionHandler(nil,.badURL("URL not working"))
        return }
        URLSession.shared.dataTask(with: myURL) { (data, response, error) in
            if let error = error {
                completionHandler(nil,.decodingError(error))
            }
            if let data = data {
                do {
                    let brooklynLibraryData = try JSONDecoder().decode(BrooklynLibrary.self, from: data)
                    completionHandler(brooklynLibraryData.locations, nil)
                } catch {
                    completionHandler(nil,.decodingError(error))
                }
            }
        }.resume()
    }
}
