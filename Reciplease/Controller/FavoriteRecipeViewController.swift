//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 06.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

final class FavoriteRecipeViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var recipeDisplay: RecipeDisplay?
    private var coreDataManager: CoreDataManager?
    
    // MARK: - Outlets
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var binButton: UIBarButtonItem!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteTableView.reloadData()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "FavoriteList" else {return}
        guard let recipeVc = segue.destination as? DetailRecipeViewController else {return}
        recipeVc.recipeDisplay = recipeDisplay
    }
    
    // MARK: - Action
    
    @IBAction func didTappedBinButton(_ sender: Any) {
        // ask the user if he is sure to delete everything
        let alertUser = UIAlertController(title: "Delete ?", message: "Do you really want to delete your favorite", preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.coreDataManager?.deleteAllFavorites()
            self.favoriteTableView.reloadData()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
            alertUser.addAction(okay)
            alertUser.addAction(cancel)
            present(alertUser, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource

extension FavoriteRecipeViewController: UITableViewDataSource {
    
    // configure the number of lines
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoritesRecipes.count ?? 0
    }
    // configure a cell format
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = coreDataManager?.favoritesRecipes[indexPath.row]
        return cell
    }
    // cell selected to call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoritesRecipes[indexPath.row]
        let recipeDisplay = RecipeDisplay(label: favoriteRecipe?.name ?? "", image: favoriteRecipe?.image, url: favoriteRecipe?.recipeUrl ?? "", ingredients: favoriteRecipe?.ingredients ?? [""], totalTime: favoriteRecipe?.totalTime, yield: favoriteRecipe?.yield)
        self.recipeDisplay = recipeDisplay
        performSegue(withIdentifier: "FavoriteList", sender: nil)
    }
}

// MARK: - TableView Delegate

extension FavoriteRecipeViewController: UITableViewDelegate {
    // tableView's height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoritesRecipes.isEmpty ?? true ? tableView.bounds.size.height : 0
    }
    // cell's height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    // ask data source if the row is editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // delete a recipe from the tableView
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let transform = CATransform3DTranslate(CATransform3DIdentity,0 ,120,0)
        cell.layer.transform = transform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
