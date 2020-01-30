//
//  WebContentProvider.swift
//  AIR1912
//
//  Created by Infinum on 23/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire


class WebContentHandler{

    func insertNewContent(for content:DBContent, completion: @escaping (Result<[DBContent]>) -> Void){
        
        
        let decoder = JSONDecoder()
        var contentDic = try! content.asDictionary()
        
        contentDic["requestType"] = "insertNewContent"
        contentDic["overview"] = " "
        Alamofire
            .request("https://cortex.foi.hr/meetup/DBContentHandler.php", method: .get, parameters: contentDic)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DBContent]>) in
                switch response.result {
                case .success(let content):
                    completion(.success(content))
                case .failure(let error):
                completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }
    

    
}


