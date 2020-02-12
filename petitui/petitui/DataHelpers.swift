//
//  DataHelpers.swift
//  petitui
//
//  Created by Jose D. on 22/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation
import UIKit
//Displays an alert with a message depending on the string passed through parameters
class DataHelpers{
    
    static func displayAlert(userMessage:String, alertType: Int)->UIAlertController{
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
        return alert
        //       self.present(alert, animated: true, completion: nil)
        
    }
    
    //
    static func isUsernameValid(_ username: String) -> Bool {
        return true
    }
    
    //
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    //
    static func isValidRepeatedPassword(_ repeatedPassword: String , _ userPassword : String) -> Bool {
        return userPassword == repeatedPassword
    }
    

    
    
}

