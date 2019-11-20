//
//  UserPost.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation


struct UserPost: Codable {
    let idUsers:String?
    let name:String
    let surname:String
    let email:String
    let password:String
    
    var dictonaryReturned: [String: Any]{
        return [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
    }
}
