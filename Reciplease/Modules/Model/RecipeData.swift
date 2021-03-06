//
//  RecipeData.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 07.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import Foundation

//MARK: - RecipesSearch

struct RecipeSearch: Decodable {
    let q: String?
    let to: Int?
    let count: Int?
    let hits: [Hit]
}

//MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipes
}

//MARK: - Recipe
struct Recipes: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Int?
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int?
}

//MARK: - Ingredients
struct Ingredient: Decodable {
    let text: String
    let weight: Double
}

//MARK: - RecipeDisplay
struct RecipeDisplay {
    let label: String
    let image: Data?
    let url: String
    let ingredients: [String]
    let totalTime: String?
    let yield: String?
}
