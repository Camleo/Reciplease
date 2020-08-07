//
//  URLSessionFake.swift
//  RecipleaseTests
//
//  Created by rochdi ben abdeljelil on 14.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockRecipeService: AlamoSession {
    
 //MARK: - Properties.
    private let fakeResponse: FakeResponse
    
    // MARK: - Initializer
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    //MARK: - Methods
 func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
    let httpResponse = fakeResponse.response
    let data = fakeResponse.data
    
    let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
    let urlRequest = URLRequest(url: URL(string: "https:/www.nike.com")!)
    callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}

