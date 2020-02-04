//
//  Authentication.swift
//  LoginPass
//
//  Created by Leo Leljak on 03/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit
import CodableAlamofire
import Alamofire

class Authentication {
    
    
    
    static func login(email:String, password:String, DB_URL:String , completion: @escaping (Result<String>) -> Void)
    {
        
        let dictionary:[String:String] = ["name":email, "password": password]
        
        let decoder = JSONDecoder()
        Alamofire
            .request(DB_URL, method: .get, parameters: dictionary)
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
