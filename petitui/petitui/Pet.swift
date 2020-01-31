// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let animal = try? newJSONDecoder().decode(Animal.self, from: jsonData)

import Foundation

struct Pet: Codable {
    let idOwner, name, idType, genre: String
    let age, location, animalDescription, preferedPhoto: String?
    let idBreed: String
    let id: Int?
    
    init(idOwner:String,idType:String,name:String,genre:String,age:String,location:String,animalDescription:String,idBreed:String) {
        self.idOwner = idOwner
        self.idType = idType
        self.name = name
        self.genre = genre
        self.age = age
        self.location = location
        self.animalDescription = animalDescription
        self.idBreed = idBreed
        self.preferedPhoto = nil
        self.id = nil
    }

    enum CodingKeys: String, CodingKey {
        case idOwner = "id_owner"
        case name
        case idType = "id_type"
        case genre, age, location
        case animalDescription = "description"
        case preferedPhoto = "prefered_photo"
        case idBreed = "id_breed"
        case id
    }
    
}
