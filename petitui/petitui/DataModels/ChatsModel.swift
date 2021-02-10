//
//  ChatsModel.swift
//  petitui
//
//  Created by Jose D. on 03/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
struct ChatsResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var chat: [ChatListElement]?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case chat
    }
    
}

struct ChatResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var chat: Chat?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case chat
    }
    
}

struct Chat: Codable {
    var id: Int
    var idOwner: Int
    var idAdopter: Int
    var idAnimal: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case idOwner = "id_animal_owner"
        case idAdopter = "id_adopter"
        case idAnimal = "id_animal"
        
    }
    
}

struct ChatListElement: Codable {
    var id: Int?
    var receiver: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case receiver
        
    }
    
    
    
}
struct MessageData: Codable {
    var id: Int?
    var chatId: Int
    var idOwner:Int
    var message: String
    
    init(chatId:Int,idOwner:Int,message:String) {
        self.chatId = chatId
        self.idOwner = idOwner
        self.message = message
        self.id = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case idOwner = "id_owner_message"
        case message
        
    }
    
}

struct MessageDataResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var message: MessageData?
    
    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case errorMsg
        case message
        
    }
    
}
