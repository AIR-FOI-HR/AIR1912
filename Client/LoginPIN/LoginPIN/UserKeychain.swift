//
//  UserKeychain.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftKeychainWrapper

class UserKeychain {
    
    enum UserKeychainKey: String {
        case email = "email"
        case password = "password"
        case nickname = "nickname"
        case avatar = "avatar"
        case id = "id"
        case lat = "lat"
        case lon = "lon"
        case name = "name"
        case surname = "surname"
        case pin = "pin"
    }
  
    
    func saveSessionData(email:String, password:String, nickname:String, avatar:String, id:Int, name:String, surname:String)->Bool{
        
        guard KeychainWrapper.standard.set(password, forKey: UserKeychainKey.password.rawValue),
            KeychainWrapper.standard.set(email, forKey: UserKeychainKey.email.rawValue),
            KeychainWrapper.standard.set(nickname, forKey: UserKeychainKey.nickname.rawValue),
            KeychainWrapper.standard.set(avatar, forKey: UserKeychainKey.avatar.rawValue),
        KeychainWrapper.standard.set(id, forKey: UserKeychainKey.id.rawValue),
        KeychainWrapper.standard.set(name, forKey: UserKeychainKey.name.rawValue),
        KeychainWrapper.standard.set(surname,forKey: UserKeychainKey.surname.rawValue)
            else {
               return false
                
        }
        return true
    }
    
    func saveLocationData(latitude:Double, longitude:Double)->Bool{
        guard KeychainWrapper.standard.set(latitude, forKey: UserKeychainKey.lat.rawValue),
            KeychainWrapper.standard.set(longitude, forKey: UserKeychainKey.lon.rawValue)
            else {
               return false
                
        }
        return true
    }
    
    func getLatestLocation()-> CLLocation{
        
        let lat = KeychainWrapper.standard.double(forKey: UserKeychainKey.lat.rawValue)
        let lon = KeychainWrapper.standard.double(forKey: UserKeychainKey.lon.rawValue)
        
        let coordinates = CLLocation(latitude: lat!, longitude: lon!)
        
        
        return coordinates
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
    
    func getName() -> String? {
         
        let name = KeychainWrapper.standard.string(forKey: UserKeychainKey.name.rawValue)
         return name
     }
 
    func getSurname() -> String? {
         
        let surname = KeychainWrapper.standard.string(forKey: UserKeychainKey.surname.rawValue)
         return surname
     }
    
    
    func getAvatar() -> String? {
        
        let avatar = KeychainWrapper.standard.string(forKey: UserKeychainKey.avatar.rawValue)
        return avatar
    }
    
    func getID() -> Int? {
          
        let id = KeychainWrapper.standard.integer(forKey: UserKeychainKey.id.rawValue)
          return id
      }
    func getPIN() ->String?{
        let pin = KeychainWrapper.standard.string(forKey: UserKeychainKey.pin.rawValue)
        return pin
    }
    
    func savePIN(pin:String) ->Bool{
        KeychainWrapper.standard.set(pin, forKey: UserKeychainKey.pin.rawValue)
    }
    
    public func hasSessionData() -> Bool {
        
        guard KeychainWrapper.standard.string(forKey: UserKeychainKey.email.rawValue) != "" && KeychainWrapper.standard.string(forKey: UserKeychainKey.password.rawValue) != "" && KeychainWrapper.standard.string(forKey: UserKeychainKey.nickname.rawValue) != "" && KeychainWrapper.standard.string(forKey: UserKeychainKey.avatar.rawValue) != "" &&
            KeychainWrapper.standard.string(forKey: UserKeychainKey.name.rawValue) != "" && KeychainWrapper.standard.string(forKey: UserKeychainKey.surname.rawValue) != ""
        else {
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
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.name.rawValue) else {
                   return false
        }
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.surname.rawValue) else {
                   return false
        }
        guard KeychainWrapper.standard.removeObject(forKey: UserKeychainKey.id.rawValue) else {
                          return false
               }
        return true
    }
}
