//
//  EdamanTestCase.swift
//  RecipleaseTests
//
//  Created by rochdi ben abdeljelil on 14.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//
@testable import Reciplease
import XCTest

class EdamanTestCase: XCTestCase {

    // MARK: - Error
    func testGetRecipeShouldPostFailedCallbackError() {
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        let fixer = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: nil, response: nil, error: FakeResponseData.error)))
        
        fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            guard case .failure(let error) = result else {
                XCTFail("testEdamanShouldPostFailedCallbackError")
                return
            }
            
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - No data
    func testGetRecipeShouldPostFailedCallbackIfNodData() {
        // Given
        let fixer = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: FakeResponseData.incorrectData, response: nil, error: FakeResponseData.error)))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            guard case .failure(let error) = result else {
                XCTFail("testGetRecipeShouldPostFailedCallbackIfNodData Fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Incorrect response
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let fixer = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseKO, error: nil)))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            guard case .failure(let error) = result else {
                XCTFail("testGetRecipeShouldPostFailedCallbackIfIncorrectResponse")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Undecodable data
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let fixer = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            guard case .failure(let error) = result else {
                XCTFail("testGetRecipeShouldPostFailedCallbackIfIncorrectData")
                return
            }
            
            XCTAssertNotNil(error)
            //Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Success
    func testGetRecipeShouldPostSuccessCallbackIfNoMissingData() {
        // Given
        let fixer = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseOK, error: nil)))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "")]) { (result: Result<RecipeSearch, NetWorkError>) in
            guard case .success(let data) = result else {
                XCTFail("testEdamanShouldPostFailedCallbackError")
                return
            }
            
            XCTAssertEqual(data.hits[0].recipe.ingredients[0].text, "")
            // Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.01)
    }
    
    func testGetRecipeShoulPostFailedCallBackError() {
        //Given
        let recipe = EdamanService()
        let service = RequestCall(networkCall: NetworkCall(session: MockRecipeService(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseOK, error: nil)))
        // When
        service.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
            recipe.getRecipe { result in
                guard case .failure(let error) = result else {
                    XCTFail("testGetRecipeShoulPostFailedCallBackError fail")
                    return
                }
                XCTAssertNotNil(error)
                
                // Then
            }
            
        }
        
    }
}
