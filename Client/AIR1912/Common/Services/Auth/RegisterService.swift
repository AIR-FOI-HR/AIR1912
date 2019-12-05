//
//  AuthService.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class RegisterService {
    
    func register(with newUser:User, completion: @escaping (Result<User>) -> Void)
    {
        let decoder = JSONDecoder()
        let newUserDict = try! newUser.asDictionary()
        
        Alamofire
            .request("http://air1912.000webhostapp.com/RegisterService.php", method: .get, parameters: newUserDict)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<User>) in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
            }
        }
    }
    
}
