//
//  User.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

enum Avatar: String, CaseIterable, Codable {
    case men
    case woman
    case boy
    case logo
    
    var image: UIImage {
        switch self {
        case .men:
            return #imageLiteral(resourceName: "man-156584_1280")
        case .woman:
            return #imageLiteral(resourceName: "teacher-359311_1280")
        case .boy:
            return #imageLiteral(resourceName: "boy-38262_1280")
        case .logo:
            return #imageLiteral(resourceName: "Logo")
        }
    }
}

struct User: Codable {
    let nickname:String
    let idUsers:String?
    let name:String
    let surname:String
    let email:String
    let password:String
    // let avatar: Avatar
}
