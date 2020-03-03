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
import RevealingSplashView

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
            self.showSpinner()
            if(DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidPassword(userPassword!)){
                ApiManager.loginUser(email: userEmail!, password: userPassword!)
                {
                    (response) in
                    self.removeSpinner()
                    print(response)
                    if(response.code==200) {
                        if let user = response.user {
                             do {
                                let defaults = UserDefaults.standard
                                let jsonEncoder = JSONEncoder()
                                let jsonData = try jsonEncoder.encode(user)
                                defaults.set(jsonData, forKey: "user")
                            } catch  {
                                print(error)
                            }
                            self.segueLogin()
                        }
                        
                        
                    }else{
                        self.present(DataHelpers.displayAlert(userMessage:response.errorMsg ?? "Network Error", alertType: 0), animated: true, completion: nil)
                    }
                }
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
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logoperrete")!,iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red:174/255, green:225/255, blue:219/255, alpha:1.0))
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
        }
        
        
        
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
