//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    let topic: Topic
    let user: UserInfo
    
    init(topic: Topic, user: UserInfo) {
        self.topic = topic
        self.user = user
        // TODO: Asignar textLabelText, el título del topic
    }
    
    func getURLAvatar() -> String {
        let userPath = self.user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(56)")
        let url = apiURL + userPath
        return url
    }
}
