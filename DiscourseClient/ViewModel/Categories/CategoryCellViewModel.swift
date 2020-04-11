//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 10/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa una categoría en la lista
class CategoryCellViewModel {
    let category: Category
    
    init(category: Category) {
        self.category = category
    }
}
