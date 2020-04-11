//
//  CreateTopicRequest.swift
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct CreateTopicRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let title: String
    let createdAt: String
    
    init(title: String,
         createdAt: String) {
        self.title = title
        self.createdAt = createdAt
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "title" : title,
            "raw" : title,
            "created_at" : createdAt
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
