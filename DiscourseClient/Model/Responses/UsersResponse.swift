//
//  UsersResponse.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    var directoryItems : [User]
    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}

struct User: Codable {
    var id : Int
    var user : UserInfo
}
