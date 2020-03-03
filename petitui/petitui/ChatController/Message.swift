//
//  Message.swift
//  petitui
//
//  Created by Jose D. on 20/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member {
    let name: String
    let image: UIImage
    let id : Int
}

struct Message {
    let member: Member
    let text: String
    let messageId: String
}

extension Message: MessageType {
    var sender: SenderType {
        return Sender(senderId: member.name, displayName: member.name)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    var kind: MessageKind {
        return .text(text)
    }
}



