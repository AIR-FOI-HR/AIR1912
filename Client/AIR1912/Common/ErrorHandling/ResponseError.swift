//
//  ResponseError.swift
//  AIR1912
//
//  Created by Infinum on 04/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

struct ResponseError: Codable, Error {
    let title: String
    let message: String
}
