import UIKit
import SkyFloatingLabelTextField
import Foundation

class RecoverPageViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var userEmail: SkyFloatingLabelTextField!
    
    
    
    @IBAction func recoverButton(_ sender: Any) {
        let userRecoverEmail = userEmail.text;
        
        if(userRecoverEmail!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            if(DataHelpers.isValidEmail(userRecoverEmail!)){
                print("SENDED")
            }else{
                self.present(DataHelpers.displayAlert(userMessage: "Invalid email", alertType: 0), animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        userEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userEmail:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
}

