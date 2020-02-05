////
////  LoginPageModel.swift
////  petitui
////
////  Created by Jose D. on 22/01/2020.
////  Copyright © 2020 Sergio. All rights reserved.
////
//
//import Foundation
//import Alamofire
//class LoginPageModel {
//    let userEmail:String = "";
//    let userPassword:String = "";
//    
//    func loginUser(email:String,password:String)  {
//        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/login")
//        let user=User( email: email, password: password)
//        AF.request(url!,
//                   method: .post,
//                   parameters:user,
//                   encoder: JSONParameterEncoder.default
//            
//        ).response { response in
//            do{
//                let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
//                if(responseData.code==200) {
//                    
//                    self.present(DataHelpers.displayAlert(userMessage:"successful login!", alertType: 1), animated: true, completion: nil)
//                    
//                }else{
//                    self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
//                }
//            }catch{
//                print(error)
//                
//            }
//        }
//        
//    }
//}
//
