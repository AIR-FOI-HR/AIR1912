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
    
    enum UserDefaultKey: String {
        case email = "email"
        case password = "password"
    }
  

    
    func saveData(email:String, password:String)->Bool{
        guard KeychainWrapper.standard.set(password, forKey: "password"),
            KeychainWrapper.standard.set(email, forKey: "email") else {
               return false
        }
        return true
    }
    
    func getEmail() -> String {
        
        let email = KeychainWrapper.standard.string(forKey: "email")
        return email!

    }
    
    func getPassword() -> String {
        let password = KeychainWrapper.standard.string(forKey: "password")
        return password!
    }
    
    public func hasData() -> Bool {
        
        guard KeychainWrapper.standard.string(forKey: "email") != nil else {
            return false
        }
        
        guard KeychainWrapper.standard.string(forKey: "password") != nil else {
            return false
        }
        return true
        
    }
    
    func removeData() -> Bool {
        guard hasData() else {
            return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserDefaultKey.email.rawValue) else {
            return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserDefaultKey.password.rawValue) else {
                   return false
               }
        return true
        
        
    }
    

}

