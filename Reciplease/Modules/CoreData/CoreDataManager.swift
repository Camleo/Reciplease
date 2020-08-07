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
    
    var favoritesRecipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
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
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.name = name
        recipe.image = image
        recipe.ingredients = ingredientsDescription
        recipe.recipeUrl = recipeUrl
        recipe.totalTime = time
        recipe.yield = yield
        coreDataStack.saveContext()
    }
    
    /// Delete recipe from favorite thanks to his name
       func deleteRecipeFromFavorite(recipeName: String) {
           let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
           let predicate = NSPredicate(format: "name == %@", recipeName)
           request.predicate = predicate
           if let objects = try? managedObjectContext.fetch(request) {
               objects.forEach { managedObjectContext.delete($0)}
           }
           coreDataStack.saveContext()
       }
    
    /// Delete all favorites in the list
    func deleteAllFavorites() {
        favoritesRecipes.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    func checkIfRecipeIsAlreadyInYourFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name ==  %@", recipeName)
        guard let recipes = try? managedObjectContext.fetch(request) else {return false }
        if recipes.isEmpty {return false }
        return true

    }
}
