//
//  FavoritesAnimalsViewController.swift
//  petitui
//
//  Created by Sergio on 20/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import FaveButton

class FavoritesAnimalsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var petsFeed:[Pet] = []
    var user: User?
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petsFeed.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteFeedCell
        
        
        cell.petName.text = petsFeed[indexPath.row].name
        cell.petAge.text = "\(String(petsFeed[indexPath.row].age)) years"
        ApiManager.getImage(url:petsFeed[indexPath.row].preferedPhoto){
            (data) in
            if let picture = data {
            cell.petImage.image = UIImage(data: picture)
            }
        }
        
        cell.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 0.75).cgColor
        cell.layer.borderWidth = 0.5
        cell.petName.layer.addBorder(edge: UIRectEdge.top, color: UIColor.red, thickness: 0.5)
        cell.layer.cornerRadius = 20
        cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        cell.petFavorite.setSelected(selected: true, animated: false)
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
        }
        catch  {
            
        }
        self.getUserFavorites(idUser: user!.id!)
        self.favoritesCollectionView.reloadData()
        
        self.hideKeyboardWhenTappedAround()
        ApiManager.getFeedAnimals(){pets in
//            self.petsFeed=pets
            self.favoritesCollectionView.reloadData()
            
            self.favoritesCollectionView.dataSource = self
            self.favoritesCollectionView.delegate = self
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getUserFavorites(idUser: user!.id!)
        self.favoritesCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? FavoriteFeedCell)
        let indexPath = self.favoritesCollectionView.indexPath(for: item!)
        let cell = favoritesCollectionView.cellForItem(at: indexPath!) as? FavoriteFeedCell
        let selectedPet=petsFeed[indexPath?.row ?? 0]
        let detailPetView = segue.destination as! DetailAnimalViewController
        let selectedPetID=petsFeed[indexPath?.row ?? 0].id
        detailPetView.detailPet = selectedPet
        detailPetView.detailImage = cell?.petImage
        detailPetView.detailPetID = selectedPetID
        
    }
    
    
    
    func color(_ rgbColor: Int) -> UIColor{
        return UIColor(
            red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
            blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getUserFavorites(idUser:Int){
        
        ApiManager.getFavoritesByUser(id: idUser)
        {(response) in
            self.petsFeed = response
            self.favoritesCollectionView.reloadData()
        }
        
    }
    
    
    

}
