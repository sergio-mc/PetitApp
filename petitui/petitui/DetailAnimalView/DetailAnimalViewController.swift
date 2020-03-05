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
    public var detailPetID:Int?
    var imagePicker = UIImagePickerController()
    var user: User?
    
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
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    private var favorite: Bool = false
    
    @IBAction func isFavorite(_ sender: Any) {
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
        }
        catch  {
            
        }
        createFavorite(idUser: user!.id!, idAnimal: detailPetID!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pet = detailPet, let image = detailImage {
            setValues(pet: pet, image:image)
            setOwnerData(pet:pet) 
        }
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        view1.layer.borderWidth = 0.5
        view1.layer.borderColor = UIColor.gray.cgColor
        view1.layer.cornerRadius = view1.frame.width / 4
        view2.layer.borderWidth = 0.5
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.cornerRadius = view2.frame.width / 4
        view3.layer.borderWidth = 0.5
        view3.layer.borderColor = UIColor.gray.cgColor
        view3.layer.cornerRadius = view3.frame.width / 4
        
        
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
    
    
    
    /*@IBAction func addphoto(_ sender: UIButton) {
     
     ImagePickerManager().pickImage(self){ image in
     print(image)
     let pet=Pet(idOwner: 1, type: "kira", name: "nala", sex: "no", age: 1, animalDescription: "catitapelada", breed: "spinix", latitude: 333.333, longitude: 5444.444, preferedPhoto: "catofota")
     
     ApiManager.createAnimal(pet: pet, data: image.jpegData(compressionQuality: 0.2)!){pet in print(pet)}
     }
     }*/
    
    
    func createFavorite(idUser:Int, idAnimal:Int){
        
        ApiManager.createFavorite(idUser: idUser, idAnimal: idAnimal)
        {(response) in
            print(response)
            if(response.code==200) {   
            }else{
                self.present(DataHelpers.displayAlert(userMessage:"Error creating favorite",  alertType: 0), animated: true, completion: nil)
            }
            
        }
        
    }
    
}
