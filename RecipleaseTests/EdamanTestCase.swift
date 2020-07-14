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

          let requestCall = RequestCall()
            let url = URL(string: "https://api.edamam.com/search")!
             
            
            
            // MARK: - Error
            func testGetCurrencyShouldPostFailedCallbackError() {
        
                // When
                let expectation = XCTestExpectation(description: "Wait for queue change")
                
                let fixer = RequestCall(networkCall: NetworkCall(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)))
                
                fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
                    guard case .failure(let error) = result else {
                        XCTFail("testFixerShouldPostFailedCallbackError")
                        return
                    }
                    
                    XCTAssertNotNil(error)
                    
                    // Then
                    expectation.fulfill()
                }
                
                wait(for: [expectation], timeout: 0.01)
            }
            
            // MARK: - No data
            func testGetCurrencyShouldPostFailedCallbackIfNodData() {
                // Given
                let fixer = RequestCall(networkCall: NetworkCall(session: URLSessionFake(data: FakeResponseData.incorrectData, response: nil, error: FakeResponseData.error)))
                // When
                let expectation = XCTestExpectation(description: "Wait for queue change")
                
                fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
                    guard case .failure(let error) = result else {
                        XCTFail("testGetCurrencyShouldPostFailedCallbackIfNodData Fail")
                        return
                    }
                    
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
                wait(for: [expectation], timeout: 0.01)
            }
            
            // MARK: - Incorrect response
            func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
                // Given
                let fixer = RequestCall(networkCall: NetworkCall(session: URLSessionFake(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseKO, error: nil)))
                // When
                let expectation = XCTestExpectation(description: "Wait for queue change")

                 fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
                    guard case .failure(let error) = result else {
                        XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse")
                        return
                    }
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
                wait(for: [expectation], timeout: 0.01)
            }

            // MARK: - Undecodable data
            func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
                // Given
                let fixer = RequestCall(networkCall: NetworkCall(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
                // When
                let expectation = XCTestExpectation(description: "Wait for queue change")

                 fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
                    guard case .failure(let error) = result else {
                        XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectData")
                        return
                    }

                    XCTAssertNotNil(error)
                    //Then
                    expectation.fulfill()
                }
                wait(for: [expectation], timeout: 0.01)
            }

            // MARK: - Success
            func testGetCurrencyShouldPostSuccessCallbackIfNoMissingData() {
                // Given
                let fixer = RequestCall(networkCall: NetworkCall(session: URLSessionFake(data: FakeResponseData.recipeCorrectData, response: FakeResponseData.responseOK, error: nil)))
                // When
                let expectation = XCTestExpectation(description: "Wait for queue change")

                 fixer.request(baseUrl: url, parameters: [("app_key", "0bfdb8eed80ddc3cdd44e6fe694dcc66"), ("app_id", "5a108179"), ("calories", "1200-2500"), ("to", "30"), ("q", "Burger")]) { (result: Result<RecipeSearch, NetWorkError>) in
                    guard case .success(let data) = result else {
                        XCTFail("testFixerShouldPostFailedCallbackError")
                        return
                    }

                    XCTAssertEqual(data.hits[0].recipe.ingredients[0].text, "burger")
                    // Then
                    expectation.fulfill()
                }

                wait(for: [expectation], timeout: 0.01)
            }

    }

