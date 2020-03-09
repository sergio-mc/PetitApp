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
    var imagePicker = UIImagePickerController()
    var user:User?
    
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
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            
        }
        catch  {
            
        }
        
        
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
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            
            var placeMark: CLPlacemark!
            
            placeMark = placemarks?[0]
            print("FIDI AUTOESCUELAS", placeMark)
            // Location name
            let locationName = placeMark.location
            // Street address
            let street = placeMark.thoroughfare
            // Postal code
            let postalCode = placeMark.postalCode
            // City
            let city = placeMark.subAdministrativeArea
            // Zip code
            let zip = placeMark.isoCountryCode
            // Country
            let country = placeMark.country
            var address1:String = String(street ?? "") + ", " + String(city ?? "")
            var address2:String = ", " + String(postalCode ?? "") + ", " + String(zip ?? "")
            var address:String = address1 + address2
            print(address)
           
            self.locationPet.text = address
        })
    }
    
    
    
    /*@IBAction func addphoto(_ sender: UIButton) {

               ImagePickerManager().pickImage(self){ image in
                 print(image)
                let pet=Pet(idOwner: 1, type: "kira", name: "nala", sex: "no", age: 1, animalDescription: "catitapelada", breed: "spinix", latitude: 333.333, longitude: 5444.444, preferedPhoto: "catofota")
                
                ApiManager.createAnimal(pet: pet, data: image.jpegData(compressionQuality: 0.2)!){pet in print(pet)}
             }
         }*/

       
    
    
}
