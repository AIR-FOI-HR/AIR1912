//
//  LoginRegisterResponse.swift
//  AIR1912
//
//  Created by Infinum on 03/12/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation

struct LoginRegisterResponse: Codable {
    let status: String
    let message: User
}
