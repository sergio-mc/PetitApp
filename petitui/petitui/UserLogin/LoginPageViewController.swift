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
    
    fileprivate var activityView : UIView?
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    //Displays an alert with a message depending on the string passed through parameters
    let loader = LoaderViewController()
    
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
                {
                    (isWorking) in
                    
                    if(isWorking) {
                        
                        self.segueLogin()
                        
                    
                    }
                    
                    
                }
                self.showSpinner()
                
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
    func loginUser(email:String,password:String, completion: @escaping (Bool) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user/login")
        let user=User( email: email, password: password)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            print(response);
            if(response.error == nil){
                var isWorking = false
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    if(responseData.code==200) {
                        isWorking = true
                        completion(isWorking)
                        self.removeSpinner()
                    }else{
                        self.removeSpinner()
                        self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                        completion(isWorking)
                        
                    }
                }catch{
                    print(error)
                }
            }else{
                self.present(DataHelpers.displayAlert(userMessage: "Network error", alertType: 0), animated: true, completion: nil)
            }
            
        }
        
    }
    
    func segueLogin()  {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    func showSpinner()
    {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func removeSpinner()
    {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    
}
