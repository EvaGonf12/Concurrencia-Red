import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    var id : Int
    var title : String
    var postsCount : Int
    var details : TopicDetails
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case details
    }
}

struct TopicDetails : Codable {
    var notificationLevel : Int
    var canReplyAsNewTopic : Bool
    var canFlagTopic : Bool
    var canDelete : Bool?
    var createdBy : TopicDetailUserInfo
    enum CodingKeys: String, CodingKey {
        case notificationLevel = "notification_level"
        case canReplyAsNewTopic = "can_reply_as_new_topic"
        case canFlagTopic = "can_flag_topic"
        case canDelete = "can_delete"
        case createdBy = "created_by"
    }
}

struct TopicDetailUserInfo : Codable {
    var id : Int
    var username : String
    var name : String
    var avatarTemplate : String
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case avatarTemplate = "avatar_template"
    }
}
