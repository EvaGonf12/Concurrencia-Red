//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// DataManager con las operaciones necesarias de este módulo
protocol UserDetailDataManager: class {
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ())
    func changeUserName(username: String, name: String, completion: @escaping (Result<ChangeUserNameResponse, Error>) -> ())
}
