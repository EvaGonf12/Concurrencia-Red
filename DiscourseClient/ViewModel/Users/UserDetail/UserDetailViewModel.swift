//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate: class {
    func userDetailFetched()
    func errorFetchingUserDetail(error: String)
    func errorChangedUserName(error: String)
    func changedNameSuccess()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelUserNameText: String?
    var labelUserUsername: String?
    var userImageTemplate: String?
    var userCanEditName: Bool?
    
    weak var viewDelegate: UserDetailViewDelegate?
    weak var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let username: String
    
    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.userDetailDataManager.fetchUser(username: self.username, completion: {[weak self] result in
                switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.viewDelegate?.errorFetchingUserDetail(error: error.localizedDescription)
                        }
                    case .success(let userDetails):
                        self?.labelUserIDText = "\(userDetails.user.id)"
                        self?.labelUserNameText = userDetails.user.name
                        self?.labelUserUsername = userDetails.user.username
                        self?.userCanEditName = userDetails.user.canEditName
                        self?.userImageTemplate = userDetails.user.avatarTemplate
                        DispatchQueue.main.async {
                            self?.viewDelegate?.userDetailFetched()
                        }
                }
            })
        }
    }
    
    func getURLAvatar() -> String {
        guard let imageURL = self.userImageTemplate else {return ""}
        let userPath = imageURL.replacingOccurrences(of: "{size}", with: "\(200)")
        let url = apiURL + userPath
        return url
    }
    
    func submitButtonTapped(username: String, name: String) {
        self.userDetailDataManager.changeUserName(username: username, name: name) {[weak self] (result) in
            switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.viewDelegate?.errorChangedUserName(error: error.localizedDescription)
                    }
                case .success(_):
                    DispatchQueue.main.async {
                        self?.viewDelegate?.changedNameSuccess()
                    }
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }
    
    func alertDismiss() {
        self.coordinatorDelegate?.userDetailBackButtonTapped()
    }
}
