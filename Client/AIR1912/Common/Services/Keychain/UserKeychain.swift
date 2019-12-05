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
        case nickname = "nickname"
        case avatar = "avatar"
    }
  

    
    func saveSessionData(email:String, password:String, nickname:String, avatar:String)->Bool{
        
        guard KeychainWrapper.standard.set(password, forKey: UserKeychainKey.password.rawValue),
            KeychainWrapper.standard.set(email, forKey: UserKeychainKey.email.rawValue),
            KeychainWrapper.standard.set(nickname, forKey: UserKeychainKey.nickname.rawValue),
            KeychainWrapper.standard.set(avatar, forKey: UserKeychainKey.avatar.rawValue)else {
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
    
    func getNickname() -> String? {
        
        let nickname = KeychainWrapper.standard.string(forKey: UserKeychainKey.nickname.rawValue)
        return nickname
    }
    
    func getAvatar() -> String? {
        
        let avatar = KeychainWrapper.standard.string(forKey: UserKeychainKey.avatar.rawValue)
        return avatar
    }
    
    public func hasSessionData() -> Bool {
        
        guard KeychainWrapper.standard.string(forKey: UserKeychainKey.email.rawValue) != nil && KeychainWrapper.standard.string(forKey: UserKeychainKey.password.rawValue) != nil && KeychainWrapper.standard.string(forKey: UserKeychainKey.nickname.rawValue) != nil && KeychainWrapper.standard.string(forKey: UserKeychainKey.avatar.rawValue) != nil else {
            return false
        }
        return true
    }
    
    func clearSessionData() -> Bool {
        guard hasSessionData() else {
            return true
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.email.rawValue) else {
            return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.password.rawValue) else {
                   return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.nickname.rawValue) else {
                   return false
        }
        
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.avatar.rawValue) else {
                   return false
        }
        return true
    }
}
