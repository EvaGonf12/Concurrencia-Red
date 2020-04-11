//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 10/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoriesResponse: Codable {
    var categoryList : CategoryList
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList : Codable {
    var canCreateCategory : Bool
    var canCreateTopic : Bool
    var categories : [Category]
    
    enum CodingKeys: String, CodingKey {
        case canCreateCategory = "can_create_category"
        case canCreateTopic = "can_create_topic"
        case categories
    }
}

struct Category : Codable {
    var id : Int
    var name : String
    var description : String
    var topicCount : Int
    var postCount : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case topicCount = "topic_count"
        case postCount = "post_count"
    }
}

