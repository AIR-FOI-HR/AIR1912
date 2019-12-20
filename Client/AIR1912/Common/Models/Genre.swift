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
    var name: String?
}

enum CodingKeys: String, CodingKey {
    case name = "name"
}


