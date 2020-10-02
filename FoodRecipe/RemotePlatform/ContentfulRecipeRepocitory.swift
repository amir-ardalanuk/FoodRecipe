//
//  ContentfulRecipeRepository.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import Foundation
import Contentful
import RxSwift

class ContentfulRecipeRepocitory: RecipeRepository {
    let spaceId = "kk2bw5ojx476"
    let token = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    let environmentId = "master"
    
    let client: Client
    
    init() {
        self.client = Client(spaceId: self.spaceId,
                             environmentId: self.environmentId,
                             accessToken: self.token)
    }
    func fetchRecipeList() -> Observable<[RecipeEntity]> {
        
        return Observable.create { [weak self] (observer) -> Disposable in
            guard  let self = self else {return Disposables.create {} }
            
            let query = Query.where(contentTypeId: "recipe")
            
            let task = self.client.fetchArray(of: Entry.self, matching: query) { (result) in
                switch result {
                case .success(let arrayResponse):
                    let recipeItem: [RecipeEntity] = arrayResponse.items.map { RecipeEntity(entry: $0)
                    }
                    observer.onNext(recipeItem)
                    
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
