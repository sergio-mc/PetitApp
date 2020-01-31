//
//  DetailAnimalViewController.swift
//  petitui
//
//  Created by Sergio on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class DetailAnimalViewController: UIViewController {
    
    
    @IBOutlet weak var picturePet: UIImageView!
    @IBOutlet weak var namePet: UILabel!
    @IBOutlet weak var locationPet: UILabel!
    @IBOutlet weak var racePet: UILabel!
    @IBOutlet weak var agePet: UILabel!
    @IBOutlet weak var descriptionPet: UILabel!
    @IBOutlet weak var pictureOwner: UIImageView!
    @IBOutlet weak var nameOwner: UILabel!
    @IBOutlet weak var genrePet: UILabel!
    @IBOutlet weak var favoriteIcon: UIButton!
    
    private var favorite: Bool = false

    @IBAction func isFavorite(_ sender: Any) {
        if(favorite)
        {
            favorite = false
            favoriteIcon.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            print("Eliminar animal como favorito")
        }else if (!favorite)
        {
            favorite = true
            favoriteIcon.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            print("Setear animal a favorito")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setValues()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setValues()
    {
        let name = "Sergio"
        let age = "4 years"
        let genre = "Male"
        let location = "Leganes 33"
        let animalDescription = "Animal description example"
        let idOwner = "David"
        let idType = "Beagle"
        let idBreed = "Beagle"
        let pet = Pet(idOwner: idOwner, idType: idType, name: name, genre: genre, age: age, location: location, animalDescription: animalDescription, idBreed: idBreed)
        
        namePet.text = pet.name
        locationPet.text = pet.location
        racePet.text = pet.idBreed
        agePet.text = pet.age
        descriptionPet.text = pet.animalDescription
        nameOwner.text = pet.idOwner
        genrePet.text = pet.genre
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
