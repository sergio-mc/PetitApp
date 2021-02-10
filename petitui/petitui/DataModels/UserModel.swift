//
//  User.swift
//  petitui
//
//  Created by Jose D. on 21/01/2020.
//  Copyright © 2020 Sergio. All rights reserved.
//

import Foundation



struct User: Codable {
    var id: Int?
    var email, userName, password,picture: String?
    var adminUser, active: Int?
    var latitude, longitude: String?
    var token: String?
    
    init(email:String,password:String,userName:String?) {
        
        self.email=email
        self.password=password
        self.userName=userName
        self.latitude=nil
        self.longitude=nil
        self.picture = nil
        self.id = nil
       
    }
    init(email:String,password:String) {
           
           self.email=email
           self.password=password
           self.userName=nil
           self.token = nil
           self.latitude=nil
            self.longitude=nil
           self.picture = nil
           self.id = nil
          
       }
 
    
    init(email:String,userName:String,id:Int, token:String) {
             
             self.email=email
             self.password=nil
             self.userName=userName
             self.token = token
             self.latitude=nil
            self.longitude=nil
             self.picture = nil
             self.id = id
            
         }
    init(email:String,password:String,userName:String?, latitude: String, longitude: String, picture: String, id: Int) {
           
           self.email=email
           self.password=password
           self.userName=userName
           self.latitude=latitude
           self.longitude=longitude
           self.picture = picture
           self.id = id
          
       }
    
    init(email:String,password:String,userName:String?, latitude: String, longitude: String) {
        
        self.email=email
        self.password=password
        self.userName=userName
        self.latitude=latitude
        self.longitude=longitude
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email,password
        case userName = "user_name"
        case latitude
        case picture
        case longitude
        case adminUser = "admin_user"
        case active, token
    }
    
}
