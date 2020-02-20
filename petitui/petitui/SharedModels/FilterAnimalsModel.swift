//
//  FilterAnimalsModel.swift
//  petitui
//
//  Created by user167367 on 2/20/20.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation

struct FilterAnimalsModel: Codable {
    var type, breed: String?
    var latitude, longitude: Double?
    var age, distance: Int?
  
    

    enum CodingKeys: String, CodingKey {
        case type
        case breed
        case latitude
        case longitude
        case age
        case distance
    }
    
}
