//
//  MessagesViewController.swift
//  petitui
//
//  Created by Sergio on 25/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController{

    @IBOutlet weak var messagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "AppCell") as? MessagesViewCell
        
        cell?.userImage.image = UIImage.init(imageLiteralResourceName: "dog")
        cell?.userName.text = "Aitor Polla"
        cell?.lastMessage.text = "Aitor polla ballesteros"
        
        
        
        return cell!
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
}
