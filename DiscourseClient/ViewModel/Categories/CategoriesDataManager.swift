//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 10/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Errores que pueden darse en el topics data manager
enum CategoriesDataManagerError: Error {
    case unknown
}

/// Data Manager con las opraciones necesarias de este módulo
protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> ())
}
