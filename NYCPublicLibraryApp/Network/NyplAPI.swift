//
//  NYPLAPI.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/9/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import Foundation

final class NyplAPI {
    static func getAllBranches(completionHandler: @escaping ([NYPL]?, AppError?) -> Void) {
        guard let myURL = URL.init(string: "https://data.cityofnewyork.us/resource/feuq-due4.json") else {
            completionHandler(nil,.badURL("URL not working"))
            return }
        URLSession.shared.dataTask(with: myURL) { (data, response, error) in
            if let error = error {
                completionHandler(nil,.decodingError(error))
            }
            if let data = data {
                do {
                    let unfilteredLibraryList = try JSONDecoder().decode([NYPL].self, from: data)
                    let filteredLibraryList = unfilteredLibraryList.filter{ $0.system == "NYPL" }
                    completionHandler(filteredLibraryList, nil)
                } catch {
                    completionHandler(nil,.decodingError(error))
                }
            }
            }.resume()
    }
}
