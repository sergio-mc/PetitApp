//
//  ChatListViewController.swift
//  petitui
//
//  Created by Sergio on 25/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var messagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messagesTableView.dataSource = self
        self.messagesTableView.delegate = self
        
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatListViewCell
        
        cell?.userImage.image = UIImage.init(imageLiteralResourceName: "dog")
        cell?.userName.text = "Aitor"
        cell?.lastMessage.text = "Aitor ballesteros"
        cell?.backgroundColor = UIColor.white
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 0.2
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true
        cell?.frame = CGRect(x: 0, y: 0, width: (cell?.frame.width)!, height: 20)
        
        
        return cell!
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    
}
