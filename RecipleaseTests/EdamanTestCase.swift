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
    
    func testGetRecipes_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
           let session = MockRecipeService(fakeResponse: FakeResponse(response: nil, data: nil))
           let requestService = RecipeService(session: session)
           let expectation = XCTestExpectation(description: "Wait for queue change.")
           requestService.getRecipes(ingredients: ["avocado"]) { result in
               guard case .failure(let error) = result else {
                   XCTFail("Test getData method with no data failed.")
                   return
               }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
       
       
       func testGetRecipes_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
           let session = MockRecipeService(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
           let requestService = RecipeService(session: session)
           let expectation = XCTestExpectation(description: "Wait for queue change.")
           requestService.getRecipes(ingredients: ["avocado"]) { result in
               guard case .failure(let error) = result else {
                   XCTFail("Test getData method with undecodable data failed.")
                   return
               }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
       
       func testGetRecipes_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
           let session = MockRecipeService(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
           let requestService = RecipeService(session: session)
           let expectation = XCTestExpectation(description: "Wait for queue change.")
           requestService.getRecipes(ingredients: ["avocado"]) { result in
               guard case .success(let data) = result else {
                   XCTFail("Test getData method with undecodable data failed.")
                   return
               }
               XCTAssertTrue(data.hits[0].recipe.label == "Salmon Spaghetti With Plum Tomatoes And Avocado")
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
}
