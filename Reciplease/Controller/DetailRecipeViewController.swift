//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 08.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    var recipeDisplay: RecipeDisplay?
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var ingredientDetailTableView: UITableView!
    
    
    
}

