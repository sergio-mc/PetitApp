//
//  DetailAnimalViewController.swift
//  petitui
//
//  Created by Sergio on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit


class DetailAnimalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var detailPet:Pet?
    public var detailImage:UIImageView?
    var imagePicker = UIImagePickerController()
    
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
        //        if(favorite)
        //        {
        //            favorite = false
        //            favoriteIcon.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        //            print("Eliminar animal como favorito")
        //        }else if (!favorite)
        //        {
        //            favorite = true
        //            favoriteIcon.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        //            print("Setear animal a favorito")
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pet = detailPet, let image = detailImage {
            setValues(pet: pet, image:image)
            setOwnerData(pet:pet) 
        }
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setValues(pet:Pet, image:UIImageView)
    {
        
        
        namePet.text = pet.name
        locationPet.text = "madrid"
        racePet.text = String(pet.type)
        agePet.text = String(pet.age)
        descriptionPet.text = pet.animalDescription
        genrePet.text = pet.sex
        picturePet.image = image.image
        
    }
    
    func setOwnerData(pet:Pet)  {
        ApiManager.getUser(id: pet.idOwner){
            
            user in
            
            if let username = user.userName{
                self.nameOwner.text = String(username)
                if let pictureUrl = user.picture{
                    ApiManager.getImage(url: pictureUrl){
                        
                        picture in
                        self.pictureOwner.image = UIImage(data: picture)
                    }
                }
            }
            
        }
        
        
        
    }
    
    
    
    @IBAction func addphoto(_ sender: UIButton) {

               ImagePickerManager().pickImage(self){ image in
                 print(image)
                let pet=Pet(idOwner: 1, type: "kira", name: "nala", sex: "no", age: 1, animalDescription: "catitapelada", breed: "spinix", latitude: 333.333, longitude: 5444.444, preferedPhoto: "catofota")
                
                ApiManager.createAnimal(pet: pet, data: image.jpegData(compressionQuality: 0.2)!){pet in print(pet)}
             }
         }

       
    
    
}
