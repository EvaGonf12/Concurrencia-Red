import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    var users : [UserInfo]
    var topicList : TopicList
    
    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
}

struct UserInfo : Codable {
    var id : Int
    var username : String
    var name : String?
    var avatarTemplate : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case avatarTemplate = "avatar_template"
    }
}

struct TopicList : Codable {
    var canCreateTopic : Bool
    var moreTopicsUrl : String
    var draftKey : String
    var topics : [Topic]
    
    enum CodingKeys: String, CodingKey {
        case canCreateTopic = "can_create_topic"
        case moreTopicsUrl = "more_topics_url"
        case draftKey = "draft_key"
        case topics
    }
}

struct Topic: Codable {
    var id : Int
    var title : String
    var postsCount : Int
    var createdAt : String
    var closed : Bool
    var lastPosterUsername : String
    var posters : [Poster]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case createdAt = "created_at"
        case closed
        case lastPosterUsername = "last_poster_username"
        case posters
    }
}

struct Poster : Codable {
    var extras : String?
    var description : String
    var userId : Int
    var primaryGroupId : Int?
    enum CodingKeys: String, CodingKey {
        case extras = "extras"
        case description = "description"
        case userId = "user_id"
        case primaryGroupId = "primary_group_id"
    }
}
