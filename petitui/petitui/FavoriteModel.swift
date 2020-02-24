//
//  FavoriteModel.swift
//  petitui
//
//  Created by user167367 on 2/23/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct FavoriteModel: Codable {

let idUser, idAnimal : Int

let id: Int?

    init(idAnimal:Int, idUser:Int, id:Int) {
        self.idUser = idUser
        self.idAnimal = idAnimal
        self.id = id
    }
}
