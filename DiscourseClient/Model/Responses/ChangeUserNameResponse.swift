//
//  ChangeUserNameResponse.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct ChangeUserNameResponse : Codable {
    var user : UserDetailsShort
}

struct UserDetailsShort : Codable {
    var id: Int
    var username : String
}
