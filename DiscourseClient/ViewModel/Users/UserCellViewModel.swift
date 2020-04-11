
//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// ViewModel que representa una categoría en la lista
class UserCellViewModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getURLAvatar() -> String {
        let userPath = self.user.user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(56)")
        let url = apiURL + userPath
        return url
    }
}
