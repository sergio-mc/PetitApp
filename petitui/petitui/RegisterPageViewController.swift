//
//  RegisterPageViewController.swift
//  petitui
//
//  Created by alumnos on 10/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import Foundation

class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var userEmailTF: UITextField!
    
    @IBOutlet weak var userPasswordTF: UITextField!

    @IBOutlet weak var userCompleteNameTF: UITextField!
    
    @IBOutlet weak var userPhoneNumberTF: UITextField!
    
    @IBOutlet weak var userAddressTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        /*let userRepeatPassword = repeatPasswordTextField.text;*/
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty)
        {
            
            // Display alert message
            
            displayMyAlertMessage(userMessage: "All fields are required");
            
            return;
        }else {
            
            if(isValidEmail(userEmail!) && isValidPassword(userPassword!)){
                print("OLEEE")
            }else{
                displayMyAlertMessage(userMessage: "mimimimimi");
            }
        }
        
        //Check if passwords match
        /*if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match");
            return;
            
        }*/
        
        
        
        
        // Store data
        /*let myUser:PFUser = PFUser();
        
        myUser.username = userEmail
        myUser.password = userPassword
        myUser.email = userEmail
        
        
        myUser.signUpInBackgroundWithBlock {
            (success:Bool!, error:NSError!) -> Void in
            
            println("User successfully registered")
            
            // Display alert message with confirmation.
            var myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
                self.dismissViewControllerAnimated(true, completion:nil);
            }
            
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
            
            
        }
        
        
        
        
        
        
    }
    
*/
    
        
    }
    
}
