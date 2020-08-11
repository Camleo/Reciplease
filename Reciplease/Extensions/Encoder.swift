//
//  Encoder.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 10.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
// MARK: - Properties

protocol Encoder {
    func encode(baseUrl: URL, parameters: [(String, Any)]?) -> URL
}

/// Return an URL parameted
extension Encoder {
    func encode(baseUrl: URL, parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else {return baseUrl}
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let urlParameted = urlComponents.url else {return baseUrl}
        return urlParameted
        }
    }
