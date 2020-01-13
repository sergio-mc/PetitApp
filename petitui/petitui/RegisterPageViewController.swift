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
        let userName = userCompleteNameTF.text
        let address = userAddressTF.text
        let phone = userPhoneNumberTF.text
        
        /*let userRepeatPassword = repeatPasswordTextField.text;*/
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || address!.isEmpty || phone!.isEmpty )
        {
            // Alert message
            displayMyAlertMessage(userMessage: "All fields are required!");
            return;
            
        } else {
            
            if(Validator.isValidEmail(userEmail!) && Validator.isValidPassword(userPassword!) && Validator.isValidPhone(phone!)){
                print("OLEEE")
            }else{
                displayMyAlertMessage(userMessage: "mimimimimi");
            }
        }
        
        //Check if passwords match
        /*if(userPassword != userRepeatPassword)
        {
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
