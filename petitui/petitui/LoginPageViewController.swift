//
//  LoginPageViewController.swift
//  petitui
//
//  Created by alumnos on 13/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import Foundation

class LoginPageViewController: UIViewController {
    
    
    
    @IBOutlet weak var userEmailTF: UITextField!
    
    
    @IBOutlet weak var userPasswordTF: UITextField!
    
    func displayMyAlertMessage(userMessage:String)
    {
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil, message: userMessage, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //
    func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        let userPassword = userPasswordTF.text;
        
        if(userEmail!.isEmpty || userPassword!.isEmpty)
        {
            // Alert message
            displayMyAlertMessage(userMessage: "All fields are required!");
            return;
            
        } else {
            
            if(isValidEmail(userEmail!) && isValidPassword(userPassword!)){
                print("OLEEE")
            }else{
                displayMyAlertMessage(userMessage: "mimimimimi");
            }
        }
        
        /*let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        if(userEmailStored == userEmail)
        {
            if(userPasswordStored == userPassword)
            {
                // Login is successfull
                NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                
                self.dismissViewControllerAnimated(true, completion:nil);
            }
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
 
 /*override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }*/
 
 
}
