//
//  FavoriteModel.swift
//  petitui
//
//  Created by alumnos on 04/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct FavoriteAnimalsModel: Codable {
    var id: Int?
    var idUser, idAnimal : Int?
    
      
      enum CodingKeys: String, CodingKey {
          case id
          case idUser = "id_user"
          case idAnimal = "id_animal"
      }
}



struct FavoriteResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var favorite: Favorite?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case favorite
    }
    

}
struct FavoritesResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var favorite: Favorite?
    

    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case favorite
    }
    
}
