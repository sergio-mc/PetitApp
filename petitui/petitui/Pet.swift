// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let animal = try? newJSONDecoder().decode(Animal.self, from: jsonData)

import Foundation

struct Pet: Codable {
    let  name, type, sex: String
    let animalDescription, preferedPhoto: String
    let breed: String?
    let idOwner, age : Int
    let latitude, longitude :Double
    let id: Int?
    
    init(idOwner:Int,type:String,name:String,sex:String,age:Int,animalDescription:String,breed:String, latitude:Double, longitude:Double,preferedPhoto:String, id:Int) {
        self.idOwner = idOwner
        self.name = name
        self.type = type
        self.sex = sex
        self.age = age
        self.latitude = latitude
        self.longitude = longitude
        self.animalDescription = animalDescription
        self.breed = breed
        self.preferedPhoto = preferedPhoto
        self.id = id
    }
    init(idOwner:Int,type:String,name:String,sex:String,age:Int,animalDescription:String,breed:String, latitude:Double, longitude:Double,preferedPhoto:String) {
           self.idOwner = idOwner
           self.name = name
           self.type = type
           self.sex = sex
           self.age = age
           self.latitude = latitude
           self.longitude = longitude
           self.animalDescription = animalDescription
           self.breed = breed
           self.preferedPhoto = preferedPhoto
           self.id = nil
       }
    
    enum CodingKeys: String, CodingKey {
        case idOwner = "id_owner"
        case name
        case type
        case sex, age
        case animalDescription = "description"
        case preferedPhoto = "prefered_photo"
        case breed
        case id
        case longitude
        case latitude
    }
    
}
