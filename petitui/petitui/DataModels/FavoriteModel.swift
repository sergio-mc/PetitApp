//
//  FavoriteModel.swift
//  petitui
//
//  Created by alumnos on 04/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct FavoriteModel: Codable {
    var id: Int?
    let idUser, idAnimal : Int
    init(idUser:Int,idAnimal:Int) {
        
        self.idUser=idUser
        self.idAnimal=idAnimal
        self.id = nil
        
    }
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case idUser = "id_user"
        case idAnimal = "id_animal"
   
    }
    
}
struct FavoriteResponse: Codable {
    var code: Int?
    var msg, errorMsg: String?
    var favorite: FavoriteModel?
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorMsg = "error_msg"
        case msg
        case favorite
    }
    
}
