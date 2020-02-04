//
//  LoginFactory.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

public class LoginFactory {
    static func loginProvider(forLoginType loginType: LoginType) -> Login {
      switch loginType {
      case .credentials:
          return PassLogin()
      case .pin:
         return PINLogin()
      }
   }
}
