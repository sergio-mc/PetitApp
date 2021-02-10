//
//  MessageResponse.swift
//  petitui
//
//  Created by Jose D. on 20/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct MessageResponse : Codable {

    var code: Int?
    var msg, errorMsg: String?
    var messages: [ChatMessage]?
    

    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case messages
    }
    
}

struct ChatMessage : Codable, Equatable {

    var message:String
    var id:Int
    var chatId:Int
    var owner:Int

    enum CodingKeys: String, CodingKey {
     

        case message
        case chatId = "chat_id"
        case owner = "id_owner_message"
        case id
    }
    
}
