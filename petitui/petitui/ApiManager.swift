//
//  ApiManager.swift
//
//  Created by Jose D. on 11/01/2020.
//  Copyright © 2020 Jose D. All rights reserved.
//

import Foundation
import Alamofire


//TODO: implementar loginRequest LoginResponse clases para los codable y decodable

class ApiManager {
    
    
    
    static  func doLogin(userEmail:String, userPassword:String)  {
        let url = URL(string:"https://jsonplaceholder.typicode.com/posts")
        
        AF.request( url!, method: .post, parameters: ["email":userEmail,"password":userPassword],
                    encoding: JSONEncoding.default, headers: ["Content-type": "application/json; charset=UTF-8"]).validate()
            .responseJSON { response in
                print(response)
        }
    }
    
    
    static func getData(){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/users")
        AF.request(url!,
                   method: .get
        )
            .validate()
            .responseJSON { response in
                print(response)
        }
    }
    
    static func getImage(url:String, completion: @escaping (Data) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/storage/app/\(url)")
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            catch{
                print("error")
            }
        }
        
    }
    
    
    static func getFeedAnimals( completion: @escaping ([Pet]) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/animals")
        AF.request(url!,
                   method: .get
        )
            .validate()
            .responseJSON { response in
                if(response.error == nil){
                    do{
                        let responseData:AnimalsResponse = try JSONDecoder().decode(AnimalsResponse.self, from: response.data!)
                        if(responseData.code==200) {
                            if let pets = responseData.animals {
                                completion(pets)
                            }
                        }
                    }catch{
                        print(error)
                    }
                }
        }
    }
    static func getUser(id:Int ,completion: @escaping (User) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user/one/\(id)")
        AF.request(url!, method: .get)
            .validate()
            .responseJSON { response in
                if(response.error == nil){
                    do{
                        let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                        if(responseData.code==200) {
                            if let user = responseData.user {
                                print(user)
                                completion(user)
                            }
                        }
                    }catch{
                        print(error)
                    }
                }
        }
    }
    
    static func testImage(data:Data)  {
        
        
        let image = UIImage.init(named: "beagle")
        let imgData = image!.jpegData(compressionQuality: 0.2)!
        let url = "http://0.0.0.0:8888/petit-api/public/api/animal/1"
        let parameter = ["name":"perrita prueba"]
        let headers: HTTPHeaders = [
        "Content-type": "multipart/form-data",
        "Accept": "application/json"
        ]
        
         AF.upload(multipartFormData: { multipartFormData in
             multipartFormData.append(Data("sergioparlo".utf8), withName: "name")
             multipartFormData.append(data, withName: "picture",fileName: "picture", mimeType:  "image/png")
//             multipartFormData.append(image, withName: "picture", fileName: "beagle", mimeType: "image/png")
         }, to: url)
             .response{ response in
                 print(response)
             }
               .uploadProgress(queue: .main, closure: { progress in
                   //Current upload progress of file
                   print("Upload Progress: \(progress.fractionCompleted)")
               })
               .response(completionHandler: { data in
                print(data)
                   //Do what ever you want to do with response
               })




    }
    
}
