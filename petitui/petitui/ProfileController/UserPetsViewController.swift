//
//  UserPetsViewController.swift
//  petitui
//
//  Created by Sergio on 09/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class UserPetsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var petsFeed:[Pet] = []
    
    
    @IBOutlet weak var userPetsCollection: UICollectionView!
    
    
    @IBAction func petRemove(_ sender: Any) {
        
        let deleteAlert = UIAlertController(title: "Delete Pet", message: "This pet will be deleted.", preferredStyle: UIAlertController.Style.alert)
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Ok")
            return print("Eliminado animal del usuario")
            
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              return print("Cancel")
        }))
        present(deleteAlert, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsFeed.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.userPetsCollection.dequeueReusableCell(withReuseIdentifier: "UserPetsCell", for: indexPath) as! UserPetsCollectionViewCell
        
        cell.petName.text = petsFeed[indexPath.row].name
        cell.petAge.text = "\(String(petsFeed[indexPath.row].age)) years"
        ApiManager.getImage(url:petsFeed[indexPath.row].preferedPhoto){
            response in
            if let picture = response{
                cell.petImage.image = UIImage(data: picture)
            }
            
            
            }
            
            cell.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 0.75).cgColor
            cell.layer.borderWidth = 0.5
            cell.petName.layer.addBorder(edge: UIRectEdge.top, color: UIColor.red, thickness: 0.5)
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            
            
            return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager.getFeedAnimals(){pets in
            self.petsFeed=pets
            self.userPetsCollection.reloadData()
            
            self.userPetsCollection.dataSource = self
            self.userPetsCollection.delegate = self
        }
        
    }

}
