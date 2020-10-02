//
//  RecipeRepositry.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import Foundation
import RxSwift

protocol RecipeRepository {
    func fetchRecipeList() -> Observable<[RecipeEntity]>
}

