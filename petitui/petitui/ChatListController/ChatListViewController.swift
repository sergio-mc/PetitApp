//
//  ChatListViewController.swift
//  petitui
//
//  Created by Sergio on 25/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    let decoded  = UserDefaults.standard.object(forKey: "user")
    var chatsUsers:[User]=[]
    var chats:[ChatListElement]=[]
    @IBOutlet weak var messagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let user:User = try JSONDecoder().decode(User.self, from: decoded as! Data)
            if let id = user.id {
                getChats(userId:id)
            }
           
        }
        catch  {
            print(error)
        }
        self.messagesTableView.dataSource = self
        self.messagesTableView.delegate = self
        
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatListViewCell
        if let pictureUrl = chatsUsers[indexPath.row].picture {
            ApiManager.getImage(url:pictureUrl){
                response in
                if let picture   = response {
                    cell.userImage.image = UIImage(data: picture)
                }
            }
        }
        
        
        cell.userName.text = chatsUsers[indexPath.row].userName
        cell.lastMessage.text = chatsUsers[indexPath.row].email //cambiar a prmier mensaje
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.frame = CGRect(x: 0, y: 0, width: (cell.frame.width), height: 20)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsUsers.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as! ChatListViewCell)
        let indexPath = self.messagesTableView.indexPath(for: item)
        let cell = messagesTableView.cellForRow(at: indexPath!) as! ChatListViewCell
        let selectedChat=chatsUsers[indexPath!.row]
        let detailChat = segue.destination as! ChatViewController
        if let userName = selectedChat.userName, let id = selectedChat.id {
            detailChat.member2 = Member(name: userName , image: cell.userImage.image ?? UIImage.init(imageLiteralResourceName: "cat"), id: id)
            detailChat.chatId = chats[indexPath!.row].id
        }
  
    }
    func getChats(userId:Int)  {
    ApiManager.getChats(id:userId){
                response in
                if let userChats = response.chat{
                    self.chats = userChats
                    for chat in userChats {
                        self.chatsUsers.append(chat.receiver)
                    }
                }
                self.messagesTableView.reloadData()
            }
    }
    
}
