//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 06.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var ingredients: [String] = []
    var recipeService = RecipeService()
    var recipesSearch: RecipeSearch?
    let indentifierSegue = "IngredientsToRecipes"
    
   //MARK: - Outlets
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchActivity: UIActivityIndicatorView!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        // Dissmiss Keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        manageActivityIndicator(activityIndicator: searchActivity, button: searchButton, showActivityIndicator: false)
    }
    
    //MARK: - Configure segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipesVC = segue.destination as? ListRecipeViewController {
            recipesVC.recipesSearch = recipesSearch
        }
    }
    
    @IBAction func didTapButtonAdd(_ sender: Any) {
        guard let ingredient = searchText.text, !ingredient.isBlank else {
            alert(message: "write an ingredient")
            return}
        ingredients.append(ingredient)
        ingredientsTableView.reloadData()
        searchText.text = ""
        }
    
    @IBAction func didTapSearch(_ sender: Any) {
        guard ingredients.count >= 1 else { return
            alert(message: "add an ingredient") }
        loadRecipes()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        // ask user if he wants to delete all ingredients
        let alerUserDelete = UIAlertController(title: "Delete All", message: "Are you sure you want to delete all ingredients", preferredStyle: .alert)
        // if user is ok okay to delete all
        let okay = UIAlertAction(title: "OK", style: .default, handler:  { (action) -> Void in
            self.ingredients.removeAll()
            self.ingredientsTableView.reloadData()
        })
        // if user is not ok cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        alerUserDelete.addAction(okay)
        alerUserDelete.addAction(cancel)
        present(alerUserDelete, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    

    func loadRecipes() {
        manageActivityIndicator(activityIndicator: searchActivity, button: searchButton, showActivityIndicator: true)
        recipeService.getRecipes(ingredients: ingredients) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let recipes):
                    self.recipesSearch = recipes
                    self.performSegue(withIdentifier: self.indentifierSegue, sender: nil)
                case.failure: self.alert(message: "incorrect request")
                }
                self.manageActivityIndicator(activityIndicator: self.searchActivity, button: self.searchButton, showActivityIndicator: false)
            }
        }
    }
}
    
    //MARK: - Extension TableView
    
    extension IngredientsViewController: UITableViewDataSource {
        
        //configue lines in tableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ingredients.count
        }
        // configure a cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as?
                IngredientTableViewCell else {
                    return UITableViewCell()
            }
            let ingredient = ingredients[indexPath.row]
            cell.configure(ingredient: ingredient)
            return cell
        }
        // delete a row in tableView
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                ingredients.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

