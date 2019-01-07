//
//  QueensLibraryAPI.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 12/11/18.
//  Copyright © 2018 Jane Zhu. All rights reserved.
//

import Foundation

final class QueensLibraryAPI {
    static func getAllBranches(completionHandler: @escaping (([QueensLibrary]?, AppError?) -> Void)) {
        guard let myURL = URL.init(string: "https://data.cityofnewyork.us/resource/b67a-vkqb.json") else { completionHandler(nil,.badURL("URL not working"))
            return }
        URLSession.shared.dataTask(with: myURL) { (data, response, error) in
        if let error = error {
            completionHandler(nil,.decodingError(error))
        }
        if let data = data {
            do {
                let queensLibraryData = try JSONDecoder().decode([QueensLibrary].self, from: data)
                completionHandler(queensLibraryData, nil)
            } catch {
                completionHandler(nil,.decodingError(error))
            }
        }
    }.resume()
}
}


