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
//TODO implementar crear mensaje y reaload
class ChatViewController: MessagesViewController {
    
    var messages: [Message] = []
    var member: Member!
    public var member2: Member!
    var loggedUser:User?
    public var chatId:Int?
    var timer: Timer?
    var allChatMessages:[ChatMessage]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            let user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            let decodedImage  = UserDefaults.standard.object(forKey: "picture") as? Data
            var image:UIImage=UIImage.init(imageLiteralResourceName: "cat")
            if let userImage = decodedImage {
                image=UIImage(data: userImage) ?? UIImage.init(imageLiteralResourceName: "cat")
            }
            member = Member(name: user.userName!, image: image, id: user.id!)
            
        }
        catch  {
            
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        getAllMessage()
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(getAllMessage), userInfo: nil, repeats: true)
        
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        timer?.invalidate()
    }
    
    @objc func getAllMessage() {
        ApiManager.getChatMessages(id: chatId ?? 0){
            chatMessages in
            if !self.allChatMessages.elementsEqual(chatMessages){
                self.messages = []
                for message in chatMessages {
                               let newMessage = Message(
                                member: self.getMember(id:message.owner),
                                   text: message.message,
                                   messageId: UUID().uuidString)
                               self.messages.append(newMessage)
                           }
                           self.messagesCollectionView.reloadData()
            }
           
        }
        
    }
    
  func  getMember(id:Int) ->Member{
    return member.id == id ? member : member2
    
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
        
        ApiManager.addMessage(message:MessageData(chatId: chatId ?? 0, idOwner: member.id, message: text )){
            response in
            if response.code==200{
                self.messages.append(newMessage)
                inputBar.inputTextView.text = ""
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
        
    }
}

