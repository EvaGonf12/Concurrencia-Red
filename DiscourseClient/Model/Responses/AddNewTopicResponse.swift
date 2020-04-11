import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct AddNewTopicResponse: Codable {
    var id : Int
    var username : String
    var createdAt : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case createdAt = "created_at"
    }
}
