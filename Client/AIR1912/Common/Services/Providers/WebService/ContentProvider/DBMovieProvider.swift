//
//  DBMovieProvider.swift
//  AIR1912
//
//  Created by Leo Leljak on 14/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class DBMovieProvider: DBContentProvider {
     private let decoder = JSONDecoder()
    
     func getContentByID(for id:Int, completion: @escaping (Result<[Content]>) -> Void) {
        Alamofire
        .request("https://cortex.foi.hr/meetup/ContentProvider.php?searchByID=\(id)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<[DBMovie]>) in
            switch response.result {
            case .success(let response):
             
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
