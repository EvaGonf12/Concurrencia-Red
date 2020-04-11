//
//  DeleteTopicRequest.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 10/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


struct DeleteTopicRequest: APIRequest {
    
    typealias Response = DeleteTopicResponse
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var method: Method {
        return .DELETE
    }
    
    var path: String {
        return "/t/\(self.id).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
