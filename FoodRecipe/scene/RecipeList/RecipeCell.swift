//
//  RecipeCell.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(by recipe: RecipeEntity) {
        self.recipeTitle.text = recipe.title
        guard let imageurl = recipe.photos?.asset?.url else {return}
        recipeImage.kf.setImage(with: imageurl)
    }
}
