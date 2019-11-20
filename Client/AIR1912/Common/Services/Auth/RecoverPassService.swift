//
//  RecoverPassService.swift
//  AIR1912
//
//  Created by Leo Leljak on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire


class RecoverPassService {
    
    
    func recoverPassword(with email: String, completion: @escaping (Result<RecoverPassCodes>) -> Void) {
           let decoder = JSONDecoder()
           let params:[String:String] = ["email":email]
           Alamofire
            .request("http://air1912.000webhostapp.com/RecoverPassService.php", method: .post, parameters: params)
               .responseDecodableObject(decoder: decoder) { (response: DataResponse<RecoverPassCodes>) in
                   completion(response.result)
                 
//                   switch response.result {
//                   case .success(let code):
//                       completion(.success(
//                           code))
//
//                   case .failure(let error):
//                       completion(.failure(error))
//                   }
                    
               }
       }
    
}
