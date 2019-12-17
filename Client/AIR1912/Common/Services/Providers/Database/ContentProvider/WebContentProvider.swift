//
//  WebContentProvider.swift
//  AIR1912
//
//  Created by Infinum on 17/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

func getFavouritesByUserId(with userId:Int, contentType:String, completion: @escaping (Result<[DBContent]>) -> Void)
{
    let decoder = JSONDecoder()
    let parameters = [
    "requestType": "getFavouritesByUserId",
    "parameter1": userId,
    "parameter2": contentType
        ] as [String : Any]
    
    Alamofire
        .request("https://cortex.foi.hr/meetup/RegisterService.php", method: .post, parameters: parameters)
        .validate()
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DBContent]>) in
            switch response.result {
            case .success(let favouriteContent):
                completion(.success(favouriteContent))
            case .failure(let error):
                completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
        }
    }
}
