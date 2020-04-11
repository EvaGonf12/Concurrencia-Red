//
//  SingleUserResponse.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct SingleUserResponse : Codable {
    var user : UserDetails
}

struct UserDetails : Codable {
    var id: Int
    var name : String
    var username : String
    var avatarTemplate : String
    var canEditName : Bool
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case avatarTemplate = "avatar_template"
        case canEditName = "can_edit_name"
    }
}
