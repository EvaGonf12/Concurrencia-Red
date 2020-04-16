//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate: class {
    func errorAddingTopic(error: String)
    func successAddingTopic()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String, date: String) {
        /** TODO:
         Realizar la llamada addTopic sobre el dataManager.
         Si el resultado es success, avisar al coordinator
         Si la llamada falla, avisar al viewDelegate
         */
        /*
         No hace falta la cola global
         */
        DispatchQueue.global(qos: .userInteractive).async {
            self.dataManager.addTopic(title: title, createdAt: date) {[weak self] (result) in
                switch result {
                    case .failure(let error):
                        print("FALLO")
                        self?.viewDelegate?.errorAddingTopic(error: error.localizedDescription)
                    case .success(_):
                        print("SUCCES")
                        self?.viewDelegate?.successAddingTopic()
                }
            }
        }
    }
    
    func alertDismiss() {
        self.coordinatorDelegate?.topicSuccessfullyAdded()
    }
}
