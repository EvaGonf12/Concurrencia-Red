//
//  UsersRequest.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene los latest topics
struct UsersRequest: APIRequest {
    
    typealias Response = UsersResponse
    
    let period : String
    let order : String
    
    init(period: String, order: String) {
        self.period = period
        self.order = order
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return [
            "period" : self.period,
            "order" : self.order
        ]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
