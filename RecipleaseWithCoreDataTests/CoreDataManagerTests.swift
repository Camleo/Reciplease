//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by rochdi ben abdeljelil on 07.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataManager = nil
    }
    // MARK: - Tests
       
       // test save recipe
       func testAddRecipeToFavoritesMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
           coreDataManager.addRecipesToFavorite(name: "Salmon Spaghetti With Plum Tomatoes And Avocado", image: Data(), ingredientsDescription: [""], recipeUrl: "http://www.biggirlssmallkitchen.com/2012/", time: "", yield: "")
           XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
           XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
           XCTAssertTrue(coreDataManager.favoritesRecipes[0].name! == "Salmon Spaghetti With Plum Tomatoes And Avocado")
       }
       // test delete all recipes
       func testDeleteAllRecipesMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
           coreDataManager.addRecipesToFavorite(name: "Salmon Spaghetti With Plum Tomatoes And Avocado", image: Data(), ingredientsDescription: [""], recipeUrl: "http://www.biggirlssmallkitchen.com/2012/", time: "", yield: "")
           coreDataManager.deleteAllFavorites()
           XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
       }
       
       // test delete one recipe
       func testDeleteOneRecipeMethod_WhenEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
           coreDataManager.addRecipesToFavorite(name: "Salmon Spaghetti With Plum Tomatoes And Avocado", image: Data(), ingredientsDescription: [""], recipeUrl: "http://www.recipes.com/recipes/8793/", time: "", yield: "")
           coreDataManager.addRecipesToFavorite(name: "Big Girls Small Kitchen", image: Data(), ingredientsDescription: [""], recipeUrl: "http://www.biggirlssmallkitchen.com/2012/", time: "", yield: "")
           coreDataManager.deleteRecipeFromFavorite(recipeName: "Salmon Spaghetti With Plum Tomatoes And Avocado")
           XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
           XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
           XCTAssertTrue(coreDataManager.favoritesRecipes[0].name! == "Big Girls Small Kitchen")
       }
       
       // test if recipe is already saved
       func testCheckingIfRecipeIsAlreadyFavorite_WhenFuncIsCalling_ThenShouldReturnTrue() {
        coreDataManager.addRecipesToFavorite(name: "Salmon Spaghetti With Plum Tomatoes And Avocado", image: Data(), ingredientsDescription: [""], recipeUrl: "http://www.biggirlssmallkitchen.com/2012/", time: "", yield: "")
        XCTAssertTrue(coreDataManager.checkIfRecipeIsAlreadyInYourFavorite(recipeName: "Salmon Spaghetti With Plum Tomatoes And Avocado"))
       }
}
