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
    
    
    func login(with name: String, completion: @escaping (Result<User>) -> Void) {
        let decoder = JSONDecoder()
        Alamofire
            .request("http://air1912.000webhostapp.com/service.php?name=\(name)")
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[User]>) in
                // completion(response.result)
                
                switch response.result {
                case .success(let users):
                    completion(.success(users[0]))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
