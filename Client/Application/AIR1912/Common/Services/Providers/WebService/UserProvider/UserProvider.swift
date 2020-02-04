//
//  AuthService.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class UserDB {
    
    
    static func getUserFromDB(with name: String, password: String, completion: @escaping (Result<[User]>) -> Void) {
        let decoder = JSONDecoder()
        Alamofire
            .request("https://cortex.foi.hr/meetup/getUserFromDB.php?name=\(name)&password=\(password)")
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[User]>) in
               // completion(response.result)
              
                switch response.result {
                case .success(let users):
                    completion(.success(
                        users))
                        
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                }
                 
            }
    }
    
    func getUserById(for userId:Int, completion: @escaping (Result<[User]>) -> Void){
           
           let decoder = JSONDecoder()
           let parameters = [
           "request": "getUserById",
           "parameter1": userId
               ] as [String : Any]
           
           Alamofire
               .request("https://cortex.foi.hr/meetup/userProvider.php", method: .get, parameters: parameters)
               .validate()
               .responseDecodableObject(decoder: decoder) { (response: DataResponse<[User]>) in
                   switch response.result {
                   case .success(let content):
                       completion(.success(content))
                   case .failure(let error):
                       completion(.failure(error))
               }
           }
           
       }
    
    
    
}
