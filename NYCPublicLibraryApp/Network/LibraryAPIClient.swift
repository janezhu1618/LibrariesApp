//
//  LibraryAPIClient.swift
//  NYCPublicLibraryApp
//
//  Created by Jane Zhu on 1/7/19.
//  Copyright © 2019 Jane Zhu. All rights reserved.
//

import Foundation

final class LibraryAPIClient {
    static func favoritesLibrary(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c337338e0948000147a77e2.mockapi.io/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false)
            }
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), false)
                return
        }
            if let _ = data {
                completionHandler(nil, true)
            }
        }
    }
    
    static func getFavorites(completionHandler: @escaping (AppError?, [Favorite]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c337338e0948000147a77e2.mockapi.io/favorites", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }
            if let data = data {
                do {
                    let favoritesData = try JSONDecoder().decode([Favorite].self, from: data)
                    completionHandler(nil, favoritesData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
