//
//  CreateAnimalController.swift
//  petitui
//
//  Created by Sergio on 12/02/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit

class CreateAnimalController: UIViewController {
    
    var typeValue : String = ""
    
    @IBOutlet weak var dogType: UIButton!
    @IBOutlet weak var catType: UIButton!
    @IBOutlet weak var otherType: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputBreed: UITextField!
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var inputDescription: UITextField!
    
    
    @IBAction func uploadPetImage(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.uploadImage.image=image
        }
        
    }
    @IBAction func setPetLocation(_ sender: Any) {
    }
    @IBAction func dogTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 2
        catType.layer.borderWidth = 0
        otherType.layer.borderWidth = 0
        typeValue = "dog"
        print(typeValue)
        
    }
    @IBAction func catTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 0
        catType.layer.borderWidth = 2
        otherType.layer.borderWidth = 0
        typeValue = "cat"
        print(typeValue)
    }
    @IBAction func othersTypeButton(_ sender: Any) {
        dogType.layer.borderWidth = 0
        catType.layer.borderWidth = 0
        otherType.layer.borderWidth = 2
        typeValue = "other"
        print(typeValue)
    }
    
    @IBAction func addPetButton(_ sender: Any) {
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
    }
    func createAnimal() {
        
    }
    
    func checkAllFields()->Bool {
        if uploadImage.image != nil {
             self.present(DataHelpers.displayAlert(userMessage: "Animal picture missing", alertType: 0), animated: true, completion: nil)
            return false}
        if typeValue.isEmpty{
             self.present(DataHelpers.displayAlert(userMessage: "Select an animal type", alertType: 0), animated: true, completion: nil)
            return false}
        if inputName.text?.isEmpty ?? true{
             self.present(DataHelpers.displayAlert(userMessage: "Add a name for the pet", alertType: 0), animated: true, completion: nil)
            return false}
        if inputAge.text?.isEmpty ?? true{
             self.present(DataHelpers.displayAlert(userMessage: "Add the age of the pet", alertType: 0), animated: true, completion: nil)
            return false}
        if inputDescription.text?.isEmpty ?? true{
             self.present(DataHelpers.displayAlert(userMessage: "Add a short description for the pet", alertType: 0), animated: true, completion: nil)
            return false}
        
        return true
    }
    
    
}
