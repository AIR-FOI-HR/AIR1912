//
//  Genre.swift
//  AIR1912
//
//  Created by Infinum on 19/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

struct Genre: Decodable {
    var id: Int?
    var name: String?
}

enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
}


