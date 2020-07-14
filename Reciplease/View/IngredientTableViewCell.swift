//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 07.07.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit
class IngredientTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Method to configure ingredient's cell
    func configure(ingredient: String) {
        ingredientLabel.text = "- \(ingredient)"
        ingredientLabel.textColor = .white
    }
}
