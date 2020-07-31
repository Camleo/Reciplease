//
//  RecipeSession.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 31.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
import Alamofire

// Mark: - Protocol AlamoSession and class SearchSession

protocol AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void)
}

final class SearchSession: AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callback(responseData)
        }
    }
}
