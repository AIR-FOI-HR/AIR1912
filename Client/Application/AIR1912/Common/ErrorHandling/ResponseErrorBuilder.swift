//
//  ErrorHandler.swift
//  AIR1912
//
//  Created by Infinum on 04/12/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation

class ResponseErrorBuilder {
    static func decodedError(fromData data: Data?, fallbackError: Error) -> Error {
        if let data = data, let responseError = try? JSONDecoder().decode(ResponseError.self, from: data) {
            return responseError
        } else {
            return fallbackError
        }
    }
}
