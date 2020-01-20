//
//  RegisterPageViewController.swift
//  petitui
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import Foundation
import SkyFloatingLabelTextField

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userAgeTF: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
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
                        errorMessage = "Must contains 8 characters and 1 number"
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
    
    //Displays an alert with a message depending on the string passed through parameters
    func displayMyAlertMessage(userMessage:String, alertType: Int)
    {
        let alertTitle: String
        
        if (alertType == 0) {
            alertTitle = "There was an error!"
        } else {
            alertTitle = "Nice!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        //Check if passwords match 46
        
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty || !userAgeTF.isOn)
        {
            // Alert message
            displayMyAlertMessage(userMessage: "All fields are required", alertType: 0);
            return;
            
        } else {
            
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( Validator.isValidPassword(userPassword!) && Validator.isValidEmail(userEmail!) && Validator.isUsernameValid(userName!) && userAgeTF.isOn){
                
                //Validation of passwords
                if (Validator.isValidRepeatedPassword(repeatedPassword!, userPassword!)) {
                    
                    displayMyAlertMessage(userMessage:"Registered!", alertType: 1)
                    
                    //Registered!!
                    
                }
            } else {
                
                displayMyAlertMessage(userMessage: "Woof! you need to fix that first", alertType: 0);
            }
        }
        
        
    }
    
}
