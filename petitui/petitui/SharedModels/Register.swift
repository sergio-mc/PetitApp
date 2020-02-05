import Foundation

struct RegisterResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var user: User?
    

    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case user
    }
    
}

struct AnimalsResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var animals: [Pet]?
    

    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case animals
    }
    
}
