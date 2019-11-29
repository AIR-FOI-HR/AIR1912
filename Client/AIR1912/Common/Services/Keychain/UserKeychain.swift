//
//  UserKeychain.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UserKeychain {
    
    enum UserKeychainKey: String {
        case email = "email"
        case password = "password"
    }
  

    
    func saveSessionData(email:String, password:String)->Bool{
        
        guard KeychainWrapper.standard.set(password, forKey: UserKeychainKey.password.rawValue),
            KeychainWrapper.standard.set(email, forKey: UserKeychainKey.email.rawValue) else {
               return false
        }
        return true
    }
    
    func getEmail() -> String? {
        
        let email = KeychainWrapper.standard.string(forKey: UserKeychainKey.email.rawValue)
        return email

    }
    
    func getPassword() -> String? {
        
        let password = KeychainWrapper.standard.string(forKey: UserKeychainKey.password.rawValue)
        return password
    }
    
    public func hasSessionData() -> Bool {
        
        guard KeychainWrapper.standard.string(forKey: UserKeychainKey.email.rawValue) != nil && KeychainWrapper.standard.string(forKey: UserKeychainKey.password.rawValue) != nil else {
            return false
        }
        return true
    }
    
    func clearSessionData() -> Bool {
        guard hasSessionData() else {
            return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.email.rawValue) else {
            return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.password.rawValue) else {
                   return false
               }
        return true
    }
}
