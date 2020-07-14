//
//  EdamanService.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 06.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
class EdamanService {
    let requestCall: RequestCall
    init(requestCall: RequestCall = RequestCall()) {
        self.requestCall = requestCall
    }
    func getRecipe(callback: @escaping(Result<String, NetWorkError>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search") else { return }
        requestCall.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            switch result {
            case.success(let data):
                callback(.success(data.hits[0].recipe.ingredients[0].text))
            case.failure(let error):
                callback(.failure(error))
            }
        }
    }
}
