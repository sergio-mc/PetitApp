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
    
    
    static func loginUser(email:String,password:String, completion: @escaping (RegisterResponse) -> ()){
        let url = URL(string:"http://0.0.0.0:8000/api/user/login")
        let user=User( email: email, password: password)
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            if(response.error == nil){
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    completion(responseData)
                }catch{
                    print(error)
                    completion(RegisterResponse())
                }
            }else{
                completion(RegisterResponse())
            }
        }
    }
    
    static func createUser(email:String,password:String,userName:String, completion: @escaping (RegisterResponse) -> ()){
        let url = URL(string:"http://0.0.0.0:8000/api/user")
        let user=User( email: email, password: password, userName: userName)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response {  response in
            if(response.error == nil){
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    completion(responseData)
                }catch{
                    print(error)
                    completion(RegisterResponse())
                }
            }else{
                completion(RegisterResponse())
            }
        }
        
    }
    
    static func updateLatLongUser(id:Int, latitude:Double, longitude:Double, completion: @escaping (RegisterResponse) -> ()){
        let url = URL(string:"http://0.0.0.0:8000/api/user\(id)")
        let user=User(latitude: latitude, longitude: longitude)
        
        AF.request(url!,
                   method: .put,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
            ).response {  response in
                if(response.error == nil){
                    do{
                        let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                        completion(responseData)
                    }catch{
                        print(error)
                        completion(RegisterResponse())
                    }
                }else{
                    completion(RegisterResponse())
                }
        }
        
    }
   static func sendEmail(email:String,completion: @escaping (Bool) -> ())  {
          let url = URL(string:"http://0.0.0.0:8000/api/user/password/reset")
          AF.request(url!,
                     method: .post,
                     parameters:["email": email],
                     encoder: JSONParameterEncoder.default
              
          ).response {  response in
              switch response.result {
              case .success:
                  do{
                      let responseData: RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                      completion(responseData.code==200)
                      
                  }catch{
                      completion(false)
                  }
              case .failure:
                  completion(false)
              }
          }
      }
    static func getData(){
        let url = URL(string:"http://0.0.0.0:8000/api/users")
        AF.request(url!,
                   method: .get
        )
            .validate()
            .responseJSON { response in
                print(response)
        }
    }
    
    static func getImage(url:String, completion: @escaping (Data) -> ()){
        let url = URL(string:"http://0.0.0.0:8000/storage/app/\(url)")
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
        let url = URL(string:"http://0.0.0.0:8000/api/animals")
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
        let url = URL(string:"http://0.0.0.0:8000/api/animals/type/\(type)")
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
        let url = URL(string:"http://0.0.0.0:8000/api/animals/filtered")
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
        let url = URL(string:"http://0.0.0.0:8000/api/user/one/\(id)")
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
        
        let url = "http://0.0.0.0:8000/api/animal"
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
    static func getChatMessages(id:Int ,completion: @escaping ([ChatMessage]) -> ()){
        let url = URL(string:"http://0.0.0.0:8000/api/chat/mesages/\(id)")
        AF.request(url!, method: .get)
            .validate()
            .responseJSON { response in
                if(response.error == nil){
                    do{
                        let responseData:MessageResponse = try JSONDecoder().decode(MessageResponse.self, from: response.data!)
                        if(responseData.code==200) {
                            if let messages = responseData.messages {
                                completion(messages)
                            }
                        }
                    }catch{
                        print(error)
                    }
                }
        }
    }
    static func getFavoritesByUser( id:Int, completion: @escaping ([Pet]) -> ()){
         let url = URL(string:"http://0.0.0.0:8000/api/favorites")
         AF.request(url!,
                    method: .get,
                    parameters: ["id_user" : id]
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
     
    /* static func createFavorite(favoriteModel: FavoriteModel ,data:Data, completion: @escaping (Bool) -> ()){
         
         let url = "http://127.0.0.1:8000/petit-api/public/api/add/favorite"
         AF.upload(multipartFormData: { multipartFormData in
             multipartFormData.append(Data(String(favoriteModel.idUser).utf8), withName: "id_user")
             multipartFormData.append(Data(String(favoriteModel.idAnimal).utf8), withName: "id_animal")
             
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
                             if let favorite = responseData.animal {
                                 completion(true)
                             }
                         }
                     }catch{
                         completion(false)
                     }
                 }
                 
                 
         }
         
     }*/
    
    
}
