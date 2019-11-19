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
    
    
    func login(with name: String, password: String, completion: @escaping (Result<[User]>) -> Void) {
        let decoder = JSONDecoder()
        Alamofire
            .request("http://air1912.000webhostapp.com/AuthService.php?name=\(name)&password=\(password)")
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[User]>) in
               // completion(response.result)
              
                switch response.result {
                case .success(let users):
                    completion(.success(
                        users))
                        
                case .failure(let error):
                    completion(.failure(error))
                }
                 
            }
    }
}
