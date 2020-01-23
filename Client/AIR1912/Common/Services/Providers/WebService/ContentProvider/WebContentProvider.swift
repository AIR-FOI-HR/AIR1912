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


class WebContentProvider{

    func getFavouritesByUserId(with userId:Int, contentType:ContentType, completion: @escaping (Result<[DBContent]>) -> Void)
    {
        let decoder = JSONDecoder()
        let parameters = [
        "requestType": "getFavouritesByUserId",
        "parameter1": userId,
        "parameter2": contentType
            ] as [String : Any]
        
        Alamofire
            .request("https://cortex.foi.hr/meetup//DBContentProvider.php", method: .get, parameters: parameters)
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

    func getContentById(for contentId: Int, completion: @escaping (Result<[DBContent]>) -> Void){
        
        let decoder = JSONDecoder()
        let parameters = [
        "requestType": "getContentById",
        "parameter1": contentId,
            ] as [String : Any]
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/DBContentProvider.php", method: .get, parameters: parameters)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DBContent]>) in
                switch response.result {
                case .success(let content):
                    completion(.success(content))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
    func checkIfContentExist(for sourceEntityId:Int, contentType: ContentType, completion: @escaping (Result<[DBContent]>) -> Void){
        
        let decoder = JSONDecoder()
        let parameters = [
        "requestType": "checkIfContentExist",
        "parameter1": sourceEntityId,
        "parameter2": contentType
            ] as [String : Any]
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/DBContentProvider.php", method: .get, parameters: parameters)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DBContent]>) in
                switch response.result {
                case .success(let content):
                    completion(.success(content))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    

    
}


