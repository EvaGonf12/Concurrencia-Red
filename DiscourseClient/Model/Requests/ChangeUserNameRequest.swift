//
//  ChangeUserNameRequest.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct ChangeUserNameRequest: APIRequest {
    
    typealias Response = ChangeUserNameResponse
    
    let username: String
    let name : String
    
    init(username: String, name: String) {
        self.username = username
        self.name = name
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(self.username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "name" : self.name
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
