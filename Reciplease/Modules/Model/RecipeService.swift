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

final class RecipeService{
    
    //MARK: -Properties
    
    private let session: AlamoSession
    
    //MARK: -Initializer
    
    init(session: AlamoSession = SearchSession()) {
        self.session = session
    }
    
    //MARK: -Method
    
    func getRecipes(ingredients: [String], callback: @escaping (Result<RecipeSearch, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?q=\(ingredients.joined(separator: ","))&app_id=\(ApiSet.app_id)&app_key=\(ApiSet.app_key)") else { return }
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(RecipleaseError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(RecipleaseError.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(Reciplease.self, from: data) else {
                callback(.failure(RecipleaseError.undecodable))
                return
            }
            callback(.success(dataDecoded))
        }
        
    }
    
}
