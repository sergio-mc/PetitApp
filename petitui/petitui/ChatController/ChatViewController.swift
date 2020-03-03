//
//  ChatViewController.swift
//  petitui
//
//  Created by Jose D. on 24/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import InputBarAccessoryView
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var messages: [Message] = []
    var member: Member!
    var member2: Member!
    var loggedUser:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            let user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            member = Member(name: user.userName!, image: UIImage.init(imageLiteralResourceName: "cat"), id: user.id!)
            
        }
        catch  {
            
        }
        
        
        member2 = Member(name: "bluemoon",  image: UIImage.init(imageLiteralResourceName: "cat"), id: 2)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        getAllMessage()
        
    }
    
    func getAllMessage() {
        ApiManager.getChatMessages(id: 1){
            chatMessages in
//            chatMessages.filter()
            for messages in chatMessages {
                let newMessage = Message(
                    member: self.member2,
                    text: messages.message,
                    messageId: UUID().uuidString)
                self.messages.append(newMessage)
            }
            self.messagesCollectionView.reloadData()
        }
        
    }
    
}
extension ChatViewController: MessagesDataSource {
    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() ->SenderType {
        return Sender(senderId: member.name, displayName: member.name)
        
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 12
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(
            string: message.sender.displayName,
            attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    func heightForLocation(message: MessageType,
                           at indexPath: IndexPath,
                           with maxWidth: CGFloat,
                           in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}
extension ChatViewController: MessagesDisplayDelegate {
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) {
        
        let message = messages[indexPath.section]
        avatarView.backgroundColor = UIColor.black
        avatarView.image = message.member.image
    }
}
extension ChatViewController: InputBarAccessoryViewDelegate {
    internal func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        
        let newMessage = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)
        print(text)
        messages.append(newMessage)
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
}
