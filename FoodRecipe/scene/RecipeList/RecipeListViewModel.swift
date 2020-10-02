//
//  RecipeListViewModel.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipeListViewModel {
    func getList() -> Driver<[RecipeEntity]>
    func select(on indexPath: IndexPath)
    var navigateToDetailWith: PublishSubject<RecipeEntity> {get}
}

class RecipeListViewModelImpl: RecipeListViewModel {
    
    var navigateToDetailWith = PublishSubject<RecipeEntity>()
    let recipeRepository: RecipeRepository
    var selectedRecipe = PublishSubject<String>()
    var recipeItem = [RecipeEntity]()
    
    init(repositry: RecipeRepository) {
        self.recipeRepository = repositry
    }
    
    func getList() -> Driver<[RecipeEntity]> {
        return recipeRepository.fetchRecipeList()
            .share(replay: 1, scope: .whileConnected)
            .do(onNext: { (list) in
                self.recipeItem = list
            })
            .asDriver(onErrorJustReturn: [])
    }
    
    func select(on indexPath: IndexPath) {
        let item = self.recipeItem[indexPath.row]
        navigateToDetailWith.onNext(item)
    }
    
    
}
