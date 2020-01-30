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
import Alamofire

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    //Displays an alert with a message depending on the string passed through parameters
    
    
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        let userPassword = userPasswordTF.text;
        
        if(userEmail!.isEmpty || userPassword!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            if(DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidPassword(userPassword!)){
                loginUser(email: userEmail!, password: userPassword!)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    func loginUser(email:String,password:String)  {
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user/login")
        let user=User( email: email, password: password)
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            print(response);
            do{
                let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                if(responseData.code==200) {
                    
                    self.present(DataHelpers.displayAlert(userMessage:"successful login!", alertType: 1), animated: true, completion: nil)
                    
                }else{
                    self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                    
                }
                
            }catch{
                print(error)
                
            }
        }
        
    }
    
    
    
}
