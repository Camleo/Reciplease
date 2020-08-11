//
//  RecipeService.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 31.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation

// MARK: - Reciplease Errors

enum RecipleaseError: Error {
    case noData, incorrectResponse, undecodable
}

final class RecipeService: Encoder {
    
    //MARK: -Properties
    
    private let session: AlamoSession
    
    //MARK: -Initializer
    
    init(session: AlamoSession = SearchSession()) {
        self.session = session
    }
    
    //MARK: -Method
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeSearch, Error>) -> Void) {
        guard let stringUrl = URL (string: "https://api.edamam.com/search") else {return}
        let url = encode(baseUrl: stringUrl, parameters: [("q", ingredients),("to", "30"),("app_id","5a108179"),("app_key","0bfdb8eed80ddc3cdd44e6fe694dcc66")])
            session.request(with: url) { responseData in
                
            guard let data = responseData.data else {
                callback(.failure(RecipleaseError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(RecipleaseError.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeSearch.self, from: data) else {
                callback(.failure(RecipleaseError.undecodable))
                return
            }
            callback(.success(dataDecoded))
        }
        
    }
    
}

