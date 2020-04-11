//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics(error: String)
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    var topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        self.getLastestTopics()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        // TODO: Seguramente debamos recuperar de nuevo los topics del datamanager, y pintarlos de nuevo
        self.getLastestTopics()
    }
    
    func getLastestTopics() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.topicsDataManager.fetchAllTopics {[weak self] result in
                switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.viewDelegate?.errorFetchingTopics(error: error.localizedDescription)
                        }
                    case .success(let topicsInfo):
                        self?.topicViewModels.removeAll()
                        let topics = topicsInfo.topicList.topics.filter { (topic) -> Bool in
                            return !topic.closed
                        }
                        for topic in topics {
                            let userInfo = topicsInfo.users.filter { (userItem) -> Bool in
                                return userItem.username == topic.lastPosterUsername
                            }.first
                            guard let user = userInfo else {return}
                            let topicCell = TopicCellViewModel(topic: topic, user: user)
                            self?.topicViewModels.append(topicCell)
                        }
                        DispatchQueue.main.async {
                            self?.viewDelegate?.topicsFetched()
                        }
                }
            }
        }
    }
}
