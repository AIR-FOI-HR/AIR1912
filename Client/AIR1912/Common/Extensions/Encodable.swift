//
//  Encodable.swift
//  AIR1912
//
//  Created by Infinum on 28/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

extension Encodable {
    
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

