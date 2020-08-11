//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 08.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    // MARK: - Properties
    
    var recipeDisplay: RecipeDisplay?
    var coreDataManager: CoreDataManager?
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var getActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientDetailTableView: UITableView!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manageActivityIndicator(activityIndicator: getActivityIndicator, button: getDirectionButton, showActivityIndicator: false)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateFavoriteIcon()
    }
}
// MARK: - Method

extension DetailRecipeViewController {
    
    /// uptade view
    private func updateView() {
        recipeTitleLabel.text = recipeDisplay?.label
        recipeImageView.image = UIImage(data: recipeDisplay?.image ?? Data())
        yieldLabel.text = recipeDisplay?.yield
        totalTimeLabel.text = recipeDisplay?.totalTime
    }
}

// MARK: - CoreData

extension DetailRecipeViewController {
    
    /// update favorite icon
    private func updateFavoriteIcon() {
        guard coreDataManager?.checkIfRecipeIsAlreadyInYourFavorite(recipeName: recipeTitleLabel.text ?? "") == true else {
            favoriteButton.image = UIImage(named: "white heart")
            return }
        favoriteButton.image = UIImage(named: "black heart")
    }
     /// add recipes to coredata
        private func addRecipeToFavorite() {
            guard let name = recipeDisplay?.label, let image = recipeDisplay?.image, let ingredients = recipeDisplay?.ingredients, let url = recipeDisplay?.url, let time = recipeDisplay?.totalTime, let yield = recipeDisplay?.yield else {return}
            coreDataManager?.addRecipesToFavorite(name: name, image: image, ingredientsDescription: ingredients, recipeUrl: url, time: time, yield: yield)
        }
    }

// MARK: - Actions

extension DetailRecipeViewController {
    
    /// action after tapped Get dirrections Button to open url of the recipes
    @IBAction private func didTappedGetDirectionButton(_ sender: Any) {
        manageActivityIndicator(activityIndicator: getActivityIndicator, button: getDirectionButton, showActivityIndicator: true)
        guard let directionUrl = URL(string: recipeDisplay?.url ?? "") else {return}
        UIApplication.shared.open(directionUrl)
        manageActivityIndicator(activityIndicator: getActivityIndicator, button: getDirectionButton, showActivityIndicator: false)
    }
    
    /// action when favorite icon is tapped
    @IBAction private func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        // when recipe is not already in the favorite list
        if sender.image == UIImage(named: "white heart") {
            sender.image = UIImage(named: "black heart")
            alert(message: "Recipes add to your favorite list")
            addRecipeToFavorite()
            // when recipe is already in the favorite list to delete it
        } else if sender.image == UIImage(named: "black heart") {
            sender.image = UIImage(named: "white heart")
            alert(message: "recipe deleted from your list")
            coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeDisplay?.label ?? "")
            
        }
    }
}
 
// MARK: - TableViewDataSource

extension DetailRecipeViewController: UITableViewDataSource {
    // configure lines' numeber in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDisplay?.ingredients.count ?? 0
    }
    // configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipeDisplay = recipeDisplay else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsDetailCell", for: indexPath)
        let ingredient = recipeDisplay.ingredients[indexPath.row]
        cell.textLabel?.text = "- \(ingredient)"
        return cell
    }
}
