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


class CreateAnimalController: UIViewController, RadioButtonDelegate, UITextViewDelegate, MyDataSendingDelegateProtocol {
    
    var user:User?
    public var latitude : String?
    public var longitude: String?
    
    func sendDataToRegisterVC(latitude: Double, longitude: Double) {
        self.latitude = String(latitude)
        self.longitude = String(longitude)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchLocation"{
            let searchVC : SearchLocationViewController = segue.destination as! SearchLocationViewController
            searchVC.delegate = self
        }
    }
    
    
    
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
    @IBOutlet weak var inputDescription: UITextView!
    
    @IBOutlet var mainView: UIView!
    
    
    
    
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
    
    
    @IBAction func addPetButton(_ sender: Any) {
        if(checkAllFields()){
            if let idUser = user?.id{
                
                createAnimal(idOwner: idUser, type: typeValue, name: inputName.text!, sex: genre!, age: Int(inputAge.text!) ?? 0, animalDescription: inputDescription.text!, breed: inputBreed.text!, latitude: latitude ?? "", longitude: longitude ?? "", preferedPhoto: "picture")
                
                
            }
            
        }
        print(checkAllFields())
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoded  = UserDefaults.standard.object(forKey: "user")
        do {
            user = try JSONDecoder().decode(User.self, from: decoded as! Data)
            
        }
        catch  {
            
        }
        
        self.hideKeyboardWhenTappedAround()
        dogType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        dogType.layer.borderWidth = 0
        
        catType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        catType.layer.borderWidth = 0
        
        otherType.layer.borderColor = UIColor(red:163/255, green:209/255, blue:204/255, alpha: 1).cgColor
        otherType.layer.borderWidth = 0
        setupGroup()
        descriptionBox()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func checkAllFields()->Bool {
        print("age",DataHelpers.isValidage(inputAge.text!))
        if uploadImage.image == nil {
            self.present(DataHelpers.displayAlert(userMessage: "Animal picture missing", alertType: 0), animated: true, completion: nil)
            return false}
        if latitude == nil && longitude == nil {
            self.present(DataHelpers.displayAlert(userMessage: "Animal location missing", alertType: 0), animated: true, completion: nil)
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
        if inputDescription.text == "Add a description..."{
        self.present(DataHelpers.displayAlert(userMessage: "Add a short description for the pet", alertType: 0), animated: true, completion: nil)
        return false}
        
        
        
        
        
        return true
    }
    
    func createAnimal(idOwner:Int,type:String,name:String,sex:String,age:Int,animalDescription:String,breed:String, latitude:String, longitude:String,preferedPhoto:String){
          self.showSpinner()
        
        let pet=Pet(idOwner: idOwner, type: type, name: name, sex: sex, age: age, animalDescription: animalDescription, breed: breed, latitude: latitude, longitude: longitude, preferedPhoto: preferedPhoto)
        
        
        if let image = imageToUpload {
              ApiManager.createAnimal(pet: pet, data: image.jpegData(compressionQuality: 0.2)!){response
                      in
                if(response==true){
                self.removeSpinner()
                self.segueAnimalFeed()
                    self.present(DataHelpers.displayAlert(userMessage:"Animal created",  alertType: 1), animated: true, completion: nil)
                    
                }else{
                    self.removeSpinner()
                    self.present(DataHelpers.displayAlert(userMessage:"Network error",  alertType: 0), animated: true, completion: nil)
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a description..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func descriptionBox()
    {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedString.Key.paragraphStyle: style]
        inputDescription.attributedText = NSAttributedString(string: inputDescription.text, attributes: attributes)
        inputDescription.font = UIFont.systemFont(ofSize: 18.0)
        inputDescription.text = "Add a description..."
        inputDescription.textColor = UIColor.lightGray
        inputDescription.delegate = self
        
        inputDescription.layer.borderColor = UIColor(red:220/255, green:220/255, blue:220/255, alpha: 0.75).cgColor
        inputDescription.layer.borderWidth = 0.75
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.mainView.frame.origin.y == 0 {
                self.mainView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.mainView.frame.origin.y != 0 {
            self.mainView.frame.origin.y = 0
        }
    }
    
    
    
    
}

 
