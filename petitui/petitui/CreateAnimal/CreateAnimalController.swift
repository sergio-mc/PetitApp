//
//  CreateAnimalController.swift
//  petitui
//
//  Created by Sergio on 12/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import Alamofire
import MBRadioCheckboxButton


class CreateAnimalController: UIViewController, RadioButtonDelegate{
    
    func radioButtonDidSelect(_ button: RadioButton) {
        genre = button.title(for: .normal)!
        print("Select: ", button.title(for: .normal)!)
        print(genre!)
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ",  button.title(for: .normal)!)
    }
    
    
    fileprivate var activityView : UIView?
    
    var typeValue : String = ""
    var imageToUpload: UIImage?
    var groupContainer = RadioButtonContainer()
    var genre: String?
    
    @IBOutlet weak var dogType: UIButton!
    @IBOutlet weak var catType: UIButton!
    @IBOutlet weak var otherType: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputBreed: UITextField!
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var inputDescription: UITextField!
    
    @IBOutlet weak var ViewGroup1: RadioButtonContainerView!
    
    @IBOutlet weak var radioButtonMale: RadioButton!
    
    @IBOutlet weak var radioButtonFemale: RadioButton!
    
    
    @IBAction func uploadPetImage(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            
            self.uploadImage.image=image
            self.imageToUpload = image
        }
        
    }
    @IBAction func setPetLocation(_ sender: Any) {
    }
    @IBAction func dogTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 2
        catType.layer.borderWidth = 0
        otherType.layer.borderWidth = 0
        typeValue = "Dog"
        print(typeValue)
        
    }
    @IBAction func catTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 0
        catType.layer.borderWidth = 2
        otherType.layer.borderWidth = 0
        typeValue = "Cat"
        print(typeValue)
    }
    @IBAction func othersTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 0
        catType.layer.borderWidth = 0
        otherType.layer.borderWidth = 2
        typeValue = "Other"
        print(typeValue)
    }
    
    
    @IBOutlet weak var genreSelector: UISegmentedControl!
    
    
    @IBAction func addPetButton(_ sender: Any) {
        if(checkAllFields()){
            createAnimal(idOwner: 1, type: typeValue, name: inputName.text!, sex: genre!, age: Int(inputAge.text!) ?? 0, animalDescription: inputDescription.text!, breed: inputBreed.text!, latitude: 80, longitude: 80, preferedPhoto: "picture")
        }
        print(checkAllFields())
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        dogType.layer.borderWidth = 0
        
        catType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        catType.layer.borderWidth = 0
        
        otherType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        otherType.layer.borderWidth = 0
        setupGroup()
        
        
    }
    
    
    
    func checkAllFields()->Bool {
        print("age",DataHelpers.isValidage(inputAge.text!))
        if uploadImage.image == nil {
            self.present(DataHelpers.displayAlert(userMessage: "Animal picture missing", alertType: 0), animated: true, completion: nil)
            return false}
        if typeValue.isEmpty{
            self.present(DataHelpers.displayAlert(userMessage: "Select an animal type", alertType: 0), animated: true, completion: nil)
            return false}
        if inputName.text?.isEmpty ?? true{
            self.present(DataHelpers.displayAlert(userMessage: "Add a name for the pet", alertType: 0), animated: true, completion: nil)
            return false}
        if !DataHelpers.isValidage(inputAge.text ?? "n") {
            self.present(DataHelpers.displayAlert(userMessage: "Add the age of the pet", alertType: 0), animated: true, completion: nil)
            return false}
        if inputDescription.text?.isEmpty ?? true{
            self.present(DataHelpers.displayAlert(userMessage: "Add a short description for the pet", alertType: 0), animated: true, completion: nil)
            return false}
        
        return true
    }
    
    func createAnimal(idOwner:Int,type:String,name:String,sex:String,age:Int,animalDescription:String,breed:String, latitude:Double, longitude:Double,preferedPhoto:String){
          self.showSpinner()
        let pet=Pet(idOwner: idOwner, type: type, name: name, sex: sex, age: age, animalDescription: animalDescription, breed: breed, latitude: latitude, longitude: longitude, preferedPhoto: preferedPhoto)
        
        if let image = imageToUpload {
              ApiManager.createAnimal(pet: pet, data: image.jpegData(compressionQuality: 0.2)!){response
                      in
                if(response){
                self.removeSpinner()
                self.segueAnimalFeed()
                    self.present(DataHelpers.displayAlert(userMessage:"Animal created",  alertType: 1), animated: true, completion: nil)
                    
                }else{
                    self.removeSpinner()
                    self.present(DataHelpers.displayAlert(userMessage:"Error creating animal",  alertType: 0), animated: true, completion: nil)
                }
                
                
                
        }
            
          
        }
        
        
        
       
      
        
        
        
    }
    
    func showSpinner()
    {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func removeSpinner()
    {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    func segueAnimalFeed()  {
        performSegue(withIdentifier: "animalFeedSegue", sender: nil)
    }
    func setupGroup() {
            
        groupContainer.addButtons([radioButtonMale,radioButtonFemale])
        groupContainer.delegate = self
            groupContainer.selectedButton = radioButtonMale
            
            // Set cutsom color for each button
            radioButtonMale.radioButtonColor = RadioButtonColor(active: radioButtonMale.tintColor, inactive: radioButtonMale.tintColor)
            radioButtonMale.style = .circle
            radioButtonFemale.radioButtonColor = RadioButtonColor(active: radioButtonFemale.tintColor
                , inactive: radioButtonFemale.tintColor)
        radioButtonFemale.style = .circle
            
            // Set up cirlce size here
            radioButtonMale.radioCircle = RadioButtonCircleStyle.init(outerCircle: 25, innerCircle: 15, outerCircleBorder: 2, contentPadding: 25)
            radioButtonFemale.radioCircle = RadioButtonCircleStyle.init(outerCircle: 25, innerCircle: 15, outerCircleBorder: 2, contentPadding: 25)
            
        
        
        }
    
    
    
    
    
}

 
