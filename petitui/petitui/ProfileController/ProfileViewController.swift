//
//  ProfileViewController.swift
//  petitui
//
//  Created by Sergio on 09/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//
import UIKit

class ProfileViewController: UIViewController{
    
    @IBAction func userPets(_ sender: Any) {
        self.segueUserPets()
    }
    
    var user: User?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        self.userImage.image = UIImage(imageLiteralResourceName: "dog")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            if let userPicture = user?.picture{
                ApiManager.getImage(url: userPicture){
                    
                    response in
                    if let picture = response{
                        self.userImage.image = UIImage(data: picture)
                    }
                    
                    
                }
            }
            
            self.userName.text = user?.userName
            self.userEmail.text = user?.email
            self.userLocation.text = "Location"
        }
        catch  {
            
        }
        
    }
    
    func segueUserPets()  {
        performSegue(withIdentifier: "userPets", sender: nil)
    }
}

