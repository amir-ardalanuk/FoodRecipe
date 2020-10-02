//
//  RecipeDetailViewModel.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipeDetailViewModel {
    var title: Driver<String?> {get}
    var description: Driver<String?> {get}
    var imageUrl: Driver<String?> {get}
    var caleries: Driver<String?> {get}
    var tag: Driver<String?> {get}
    var isTagHidden: Driver<Bool> {get}
    
    func setEntity(_ entity: RecipeEntity)
}

class RecipeDetailViewModelImpl: RecipeDetailViewModel {
    
    var title: Driver<String?> {
        return recipeEntity.share().compactMap { $0?.title }.asDriver(onErrorJustReturn: "")
    }
    
    var description: Driver<String?> {
        return recipeEntity.share().compactMap { $0?.description }.asDriver(onErrorJustReturn: "")
    }
    
    var imageUrl: Driver<String?> {
        return recipeEntity.share().compactMap { $0?.photos?.asset?.urlString }.asDriver(onErrorJustReturn: "")
    }
    
    var caleries: Driver<String?> {
        return recipeEntity.share().compactMap { "\($0?.calories ?? 0)" }.asDriver(onErrorJustReturn: "")
    }
    
    var tag: Driver<String?> {
        return recipeEntity
            .share()
            .map { $0?.tags.map { tagItems in
                return tagItems.map { ($0.entry?.fields["name"] as? String) ?? ""}
                }?.joined(separator: " / ")
            }.asDriver(onErrorJustReturn: "--")
    }
    
    var isTagHidden: Driver<Bool> {
        return recipeEntity.share().map { ($0?.tags?.count ?? 0) == 0 }
        .asDriver(onErrorJustReturn: true)
    }
    
    var recipeEntity = BehaviorRelay<RecipeEntity?>(value: nil)
    
    func setEntity(_ entity: RecipeEntity) {
        self.recipeEntity.accept(entity)
    }
    
}
