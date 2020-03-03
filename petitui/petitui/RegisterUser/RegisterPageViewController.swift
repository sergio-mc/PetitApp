//
//  RegisterPageViewController.swift
//  petitui
//
//

import UIKit
import Foundation
import SkyFloatingLabelTextField
import Alamofire
import CoreLocation

class RegisterPageViewController: UIViewController, UITextFieldDelegate{
    
    fileprivate var activityView : UIView?
    
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
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                case userConfirmPassword:
                    if(!DataHelpers.isValidRepeatedPassword(text, userPasswordTF.text ?? "" )) {
                        errorMessage = "Passwords doesn't match"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty || !userAgeTF.isOn)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            
            return;
            
        } else {
            
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidEmail(userEmail!) && DataHelpers.isUsernameValid(userName!) && userAgeTF.isOn){
                
                //Validation of passwords
                ApiManager.createUser(email: userEmail!,password: userPassword!,userName: userName!){
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
                self.showSpinner()
                
            } else {
                
                self.present(DataHelpers.displayAlert(userMessage: "Woof! you need to fix that first", alertType: 0), animated: true, completion: nil)
            }
        }
        
    }
    
    
    func segueLogin()  {
        performSegue(withIdentifier: "registerSegue", sender: nil)
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
