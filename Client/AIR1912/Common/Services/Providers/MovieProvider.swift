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
    
    private let API_KEY = "e965f161f0ec9f1c3931495b713226e0"
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void) {
       let decoder = JSONDecoder()
        Alamofire
            .request("https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)")
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<MovieResponse>) in
                switch response.result {
                case .success(let response):
                    completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
