
//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers(error: String)
}

/// ViewModel que representa un listado de users
class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    var usersDataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []

    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }

    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest users del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos users listos para pintar
         */
        self.getUsers()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
    }
    
    func getUsers() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.usersDataManager.fetchAllUsers {[weak self] result in
                switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.viewDelegate?.errorFetchingUsers(error: error.localizedDescription)
                        }
                    case .success(let usersInfo):
                        self?.userViewModels.removeAll()
                        for user in usersInfo.directoryItems {
                            let userCell = UserCellViewModel(user: user)
                            self?.userViewModels.append(userCell)
                        }
                        DispatchQueue.main.async {
                            self?.viewDelegate?.usersFetched()
                        }
                }
            }
        }
    }
}
