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
    static func getAnimalsType(type: String, completion: @escaping ([Pet]) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/animals/type/\(type)")
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

    static func getAnimalsFilters(filterAnimalModel : FilterAnimalsModel, completion: @escaping ([Pet]) -> ()){
    let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/animals/filtered")
    AF.request(url!,
               method: .get,
               parameters:filterAnimalModel
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
    
    static func createAnimal(pet:Pet,data:Data, completion: @escaping (Bool) -> ()){
        
        let url = "http://0.0.0.0:8888/petit-api/public/api/animal"
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(String(pet.idOwner).utf8), withName: "id_owner")
            multipartFormData.append(Data(pet.name.utf8), withName: "name")
            multipartFormData.append(Data(pet.type.utf8), withName: "type")
            multipartFormData.append(Data(pet.sex.utf8), withName: "sex")
            multipartFormData.append(Data(String(pet.age).utf8), withName: "age")
            multipartFormData.append(Data(pet.animalDescription.utf8), withName: "description")
            multipartFormData.append(Data(pet.breed?.utf8 ?? "".utf8), withName: "breed")
            multipartFormData.append(Data(pet.longitude.utf8), withName: "longitude")
            multipartFormData.append(Data(pet.latitude.utf8), withName: "latitude")
            
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
            .responseJSON { response in
                if(response.error == nil){
                    do{
                        let responseData:AnimalResponse = try JSONDecoder().decode(AnimalResponse.self, from: response.data!)
                        if(responseData.code==200) {
                            if let pets = responseData.animal {
                                completion(true)
                            }
                        }
                    }catch{
                       completion(false)
                    }
                }
                
                
        }
        
    }
    
}
