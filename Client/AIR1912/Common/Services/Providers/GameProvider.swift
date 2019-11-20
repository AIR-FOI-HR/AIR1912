//
//  GameProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

class GameProvider: ContentProvider {
    
    
    private let API_KEY = "f24b13a88afd5111c365ae68e4add8bd"
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void) {
       let decoder = JSONDecoder()
        var request = URLRequest(url: URL(string: "https://api-v3.igdb.com/games")!)
        request.httpMethod = "POST"
        request.addValue(API_KEY, forHTTPHeaderField: "user-key")
        let httpBody = "fields name,category,cover,summary;".data(using: .utf8)
        request.httpBody = httpBody
        
        
        Alamofire
            .request(request)
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Game]>) in
                switch response.result {
                case .success(let games):
                    completion(.success(games))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
