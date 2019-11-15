//
//  MovieProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

class MovieProvider: ContentProvider {
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void) {
        let decoder = JSONDecoder()
        Alamofire
            .request("http://air1912.000webhostapp.com/service.php?name=Leo")
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Movie]>) in
                switch response.result {
                case .success(let movies):
                    completion(.success(movies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
