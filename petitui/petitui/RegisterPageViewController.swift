//
//  RegisterPageViewController.swift
//  petitui
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

// Check del username

import UIKit
import Foundation
import SkyFloatingLabelTextField

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var inputDate: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //DatePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(RegisterPageViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterPageViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        inputDate.inputView = datePicker
        
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case usernameTF:
                    if(text.count < 3) {
                        errorMessage = "Invalid username"
                    }
                case userEmailTF:
                    if(!Validator.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                case userPasswordTF:
                    if(!Validator.isValidPassword(text)) {
                        errorMessage = "Invalid password"
                    }
                case userConfirmPassword:
                    if(!Validator.isValidRepeatedPassword(text, userPasswordTF.text ?? "" )) {
                        errorMessage = "Passwords doesn't match"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    // Check when view is tapped and stop editing.
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    // Check when datePicker is changed and format it into string to set UiTextField.text
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        //print(datePicker.date)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        inputDate.text = dateFormatter.string(from: datePicker.date)
        //print(dateFormatter.string(from: datePicker.date))
    }
    
    //Displays an alert with a message depending on the string passed through parameters
    func displayMyAlertMessage(userMessage:String)
    {
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil, message: userMessage, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
        
    }
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        //Check if passwords match
        
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty )
        {
            // Alert message
            displayMyAlertMessage(userMessage: "(HURON SOUNDS) All fields are required!");
            return;
            
        } else {
            
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( Validator.isValidPassword(userPassword!) && Validator.isValidEmail(userEmail!) && Validator.isUsernameValid(userName!)){
              displayMyAlertMessage(userMessage:"OLEEE OLEEE CARACOLE")
                
                //Validation of passwords
                if (Validator.isValidRepeatedPassword(repeatedPassword!, userPassword!)) {
              displayMyAlertMessage(userMessage:"Miaauu! Registered")
                    //Registered!!
                    
                }
            } else {
                
                displayMyAlertMessage(userMessage: "Woof! you need to fix that first");
            }
        }
        
        
    }
    
}
