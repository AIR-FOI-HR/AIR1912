//
//  User.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation


struct User: Codable {
    let nickname:String
    let idUsers:String?
    let name:String
    let surname:String
    let email:String
    let password:String
}
