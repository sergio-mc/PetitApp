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

class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

    @IBAction func signUpButton(_ sender: Any) {
    
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        /*let userRepeatPassword = repeatPasswordTextField.text;*/
        
        //Check if passwords match
        func isValidRepeatedPassword(_ repeatedPassword: String) -> Bool {
            var areEqualPasswords : Bool = false
            
            if(userPassword != repeatedPassword)
            {
                displayMyAlertMessage(userMessage: "Guau, las contraseñas no coinciden");
                areEqualPasswords = false
            } else {
                print("Contraseñas iguales")
                areEqualPasswords = true
            }
            
            return areEqualPasswords
        }
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty )
        {
            // Alert message
            displayMyAlertMessage(userMessage: "All fields are required!");
            return;
            
        } else {
            
            if(Validator.isValidEmail(userEmail!) && Validator.isValidPassword(userPassword!) && isValidRepeatedPassword(repeatedPassword!)){
                print("OLEEE")
            }else{
                displayMyAlertMessage(userMessage: "mimimimimi");
            }
        }
        
        
  
    
    }
    
}
