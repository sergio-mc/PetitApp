//
//  Favorite.swift
//  petitui
//
//  Created by Sergio on 09/03/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    var id: Int?
    let idUser, idAnimal : Int?
    
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
