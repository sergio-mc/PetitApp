//
//  DetailAnimalViewController.swift
//  petitui
//
//  Created by Sergio on 24/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import MapKit

class DetailAnimalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var detailPet:Pet?
    public var detailImage:UIImageView?
    public var detailPetID:Int?
    var user:User?
    var chat:Chat?
    var member2:Member?
    var imagePicker = UIImagePickerController()
    var isFavorite: Favorite?
    
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
        
        if(favoriteIcon.isSelected == false)
        {
            removeFavorite(idUser: user!.id!, idAnimal: detailPetID!)
            print("Favorite deleted")
            
        }else if(favoriteIcon.isSelected == true)
        {
            createFavorite(idUser: user!.id!, idAnimal: detailPetID!)
            print("Favorite created")
            
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        if let pet = detailPet, let image = detailImage {
            setValues(pet: pet, image:image)
            setOwnerData(pet:pet) 
        }
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            
            getFavoriteByUser(idUser: user!.id!, idAnimal: detailPetID!)
            
            
        }
        catch  {
            
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
        
        racePet.text = String(pet.type)
        agePet.text = String(pet.age)
        descriptionPet.text = pet.animalDescription
        genrePet.text = pet.sex
        picturePet.image = image.image
        
        let latitudePet : Double = Double(pet.latitude) as! Double
        let longitudePet : Double = Double(pet.longitude) as! Double
        convertLatLongToAddress(latitude: latitudePet, longitude: longitudePet)
        
      
    }
    
    func setOwnerData(pet:Pet)  {
        ApiManager.getUser(id: pet.idOwner){
            owner in
            
            if let username = owner.userName{
                
                self.nameOwner.text = String(username)
                if let pictureUrl = owner.picture{
                    ApiManager.getImage(url: pictureUrl){
                        
                        response in
                        if let picture = response{
                            self.pictureOwner.image = UIImage(data: picture)
                        }
                        
                    }
                }
            }
            
        }
        
        
        
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            
            var placeMark: CLPlacemark!
            
            placeMark = placemarks?[0]
            // Street address
            let street = placeMark.thoroughfare
            // Postal code
            let postalCode = placeMark.postalCode
            // City
            let city = placeMark.subAdministrativeArea
            // Zip code
            let zip = placeMark.isoCountryCode
            // Country
            let address1:String = String(street ?? "") + ", " + String(city ?? "")
            let address2:String = ", " + String(postalCode ?? "") + ", " + String(zip ?? "")
            let address:String = address1 + address2
            print(address)
           
            self.locationPet.text = address
        })
    }
    
    
    @IBAction func contactOwner(_ sender: UIButton) {
        
        if let userId = self.user?.id, let animalOwner = self.detailPet?.idOwner, let animalId = self.detailPet?.id{
            if userId == animalOwner {
                 self.present(DataHelpers.displayAlert(userMessage:"This is your pet", alertType: 0), animated: true, completion: nil)
            }else{
            ApiManager.createChat(userId: userId , animalOwner: animalOwner, animalId: animalId)
            {
                response in
                if let chat = response.chat {
                    self.chat=chat
                    if let userName = self.nameOwner.text {
                        self.member2 = Member(name: userName , image: self.pictureOwner.image ?? UIImage.init(imageLiteralResourceName: "cat"), id: chat.idOwner)
                        self.showChat()
                    }
                } else{
                    self.present(DataHelpers.displayAlert(userMessage:"Chat service unavailable", alertType: 0), animated: true, completion: nil)
                }
            }
            
        }
        
        }
    }
    
    func showChat(){
        let chatView:ChatViewController = ChatViewController()
        chatView.chatId = chat?.id
        chatView.member2=member2
        self.present(chatView, animated: true, completion: nil)
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
    func removeFavorite(idUser:Int, idAnimal:Int){
        
        ApiManager.removeFavorite(idUser: idUser, idAnimal: idAnimal)
        {(response) in
            print(response)
            if(response.code==200) {
                self.present(DataHelpers.displayAlert(userMessage:"EXITO ;)",  alertType: 1), animated: true, completion: nil)
            }else{
                self.present(DataHelpers.displayAlert(userMessage:"Error removing favorite",  alertType: 0), animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    func getFavoriteByUser(idUser:Int, idAnimal:Int)
    {
        let favoriteAnimalsModel = FavoriteAnimalsModel(id: nil, idUser: idUser, idAnimal: idAnimal)
        ApiManager.getFavoriteByUser(favoriteAnimalModel: favoriteAnimalsModel){response in
            self.isFavorite = response
            if(self.isFavorite != nil)
            {
                self.favoriteIcon.isSelected = true
            }else{
                self.favoriteIcon.isSelected = false
            }
            
            
        }
        
    }
    
    
}

