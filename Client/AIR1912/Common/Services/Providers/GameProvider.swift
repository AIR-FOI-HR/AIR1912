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
    
    
    func getTopRatedContent(completion: @escaping (Result<[Content]>) -> Void) {
        let decoder = JSONDecoder()
         
         let headers = [
             "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com",
             "x-rapidapi-key": "8e24dd9e5dmshb82b8dcc0df400ep1f2bc1jsn0e0a57afa70e"
         ]
         
         var request = URLRequest(url: NSURL(string: "https://rawg-video-games-database.p.rapidapi.com/games")! as URL,
                                                 cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers
         
        Alamofire
         .request(request)
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<GameResponse>) in
                switch response.result {
                case .success(let response):
                 completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getLatestContent(completion: @escaping (Result<[Content]>) -> Void) {
        let decoder = JSONDecoder()
         
         let headers = [
             "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com",
             "x-rapidapi-key": "8e24dd9e5dmshb82b8dcc0df400ep1f2bc1jsn0e0a57afa70e"
         ]
         
         var request = URLRequest(url: NSURL(string: "https://rawg-video-games-database.p.rapidapi.com/games")! as URL,
                                                 cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers
         
        Alamofire
         .request(request)
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<GameResponse>) in
                switch response.result {
                case .success(let response):
                 completion(.success(response.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getPopularContent(completion: @escaping (Result<[Content]>) -> Void) {
       let decoder = JSONDecoder()
        
        let headers = [
            "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com",
            "x-rapidapi-key": "8e24dd9e5dmshb82b8dcc0df400ep1f2bc1jsn0e0a57afa70e"
        ]
        
        var request = URLRequest(url: NSURL(string: "https://rawg-video-games-database.p.rapidapi.com/games")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
       Alamofire
        .request(request)
           .responseDecodableObject(decoder: decoder) { (response: DataResponse<GameResponse>) in
               switch response.result {
               case .success(let response):
                completion(.success(response.results))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
    }
}
