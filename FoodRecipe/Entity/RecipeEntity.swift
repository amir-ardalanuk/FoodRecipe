//
//  RecipeEntity.swift
//  FoodRecipe
//
//  Created by Amir  on 10/2/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import Foundation
import Contentful

struct RecipeEntity {
    
    let calories: Int?
    let description: String?
    let title: String
    let tags: [Link]?//[String]?
    let photos: Link?
    
    init(entry: Entry) {
        calories = entry.fields["calories"] as? Int
        description = entry.fields["description"] as? String
        title = entry.fields["title"] as? String ?? "unknown"
        tags = entry.fields["tags"] as? [Link]
        photos = entry.fields["photo"] as? Link
    }
}
