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

class AuthService {
    
    
    func login(with name: String, password: String, completion: @escaping (Result<String>) -> Void) {
         var dictionary:[String:String] = ["name":name, "password": password]
               
               let decoder = JSONDecoder()
               Alamofire
                   .request("https://cortex.foi.hr/meetup/AuthService.php", method: .get, parameters: dictionary)
                   .responseDecodableObject(decoder: decoder) { (response: DataResponse<String>) in
                      // completion(response.result)
                     
                       switch response.result {
                       case .success(let isLogined):
                           completion(.success(
                               isLogined))
                               
                       case .failure(let error):
                           completion(.failure(error))
                       }
                        
                   }
           
           }
    }
    
    
    

