//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 31.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    //MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoritesRecipes: [FavoritesRecipesList] {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        guard let recipes = try? ManagedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    //MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    //MARK: -Methods
    
    
    /// Add Favorite recipes to the list
    func addRecipesToFavorite(name: String, image: Data, ingredientsDescription: [String], recipeUrl: String, time: String, yield: String) {
        let recipe = FavoritesRecipesList(context: managedObjectContext)
        recipe.name = name
        recipe.image = image
        recipe.ingredients = ingredientsDescription
        recipe.recipeUrl = recipeUrl
        recipe.totalTime = time
        recipe.yield = yield
        coreDataStack.saveContext()
    }
    
    /// Delete all favorites in the list
    func deleteAllFavorites() {
        favoritesRecipes.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
}
