//
//  RequestCall.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 06.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
final class RequestCall {
    
    private let networkCall: NetworkCall
    
    // MARK: - Initializer
    
    init(networkCall: NetworkCall = NetworkCall(session: URLSession(configuration: .default))) {
        self.networkCall = networkCall
    }
    
    func request<T: Decodable>(baseUrl: URL, parameters: [(String, Any)]?, callBack: @escaping (Result<T, NetWorkError>) -> Void) {
        networkCall.request(baseUrl: baseUrl, parameters: parameters) { data, response, error in
            guard let data = data, error == nil else {
                callBack(.failure(.noData))
                return
            }
            // Check status response code
            guard let response = response, response.statusCode == 200 else{
                callBack(.failure(.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callBack(.failure(.undecodableData))
                return
            }
            callBack(.success(dataDecoded))
        }
        
    }
}

enum NetWorkError: Error {
    case noData, incorrectResponse, undecodableData
    
}
