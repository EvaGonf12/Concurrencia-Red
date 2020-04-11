//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol CategoriesCoordinatorDelegate: class {
    //func didSelect(category: Category)
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories(error: String)
}

/// ViewModel representando un listado de categorías
class CategoriesViewModel {
    weak var coordinatorDelegate: CategoriesCoordinatorDelegate?
    weak var viewDelegate: CategoriesViewDelegate?
    var categoriesDataManager: CategoriesDataManager
    var categoryViewModels: [CategoryCellViewModel] = []

    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }
    
    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        self.getCategories()
    }
    
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return categoryViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoryViewModels.count else { return nil }
        return categoryViewModels[indexPath.row]
    }
    
    func getCategories() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.categoriesDataManager.fetchAllCategories {[weak self] result in
                switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.viewDelegate?.errorFetchingCategories(error: error.localizedDescription)
                        }
                    case .success(let categoriesInfo):
                        self?.categoryViewModels.removeAll()
                        for category in categoriesInfo.categoryList.categories {
                            let categoryCell = CategoryCellViewModel(category: category)
                            self?.categoryViewModels.append(categoryCell)
                        }
                        DispatchQueue.main.async {
                            self?.viewDelegate?.categoriesFetched()
                        }
                }
            }
        }
    }

}
