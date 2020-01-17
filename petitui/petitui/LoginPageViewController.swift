//
//  LoginPageViewController.swift
//  petitui
//
//  Created by alumnos on 13/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Foundation

class LoginPageViewController: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    func displayMyAlertMessage(userMessage:String)
    {
        let alertDisapperTimeInSeconds = 2.0
        let alert = UIAlertController(title: nil, message: userMessage, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
            alert.dismiss(animated: true)
        }
        
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
            
            if(Validator.isValidEmail(userEmail!) && Validator.isValidPassword(userPassword!)){
                print("OLEEE OLEEE LOS CARACOLE")
            }else{
                displayMyAlertMessage(userMessage: "User not foud");
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
        
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    @objc func textFieldDidChange(_ textfield: UITextField) {
    
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                
                switch textfield {
                case userEmailTF:
                    if(text.count < 0) {
                        floatingLabelTextField.errorMessage = "Email"
                    }
                case userPasswordTF:
                    if(text.count < 0) {
                        floatingLabelTextField.errorMessage = "Password"
                    }
                default:
                    print("")
                }
                
            }
        }
    }
    
    
    
}
