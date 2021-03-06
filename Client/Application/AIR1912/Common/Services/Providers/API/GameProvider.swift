//
//  GameProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

  var gameTitle = String()
  var gameId = Int()
  
class GameProvider: ContentProvider {
    func getContentByIDFromDB(for id: Int, completion: @escaping (Result<[Content]>) -> Void) {
        Alamofire
        .request("https://cortex.foi.hr/meetup/ContentProvider.php?searchByID=\(id)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<GameResponse>) in
            switch response.result {
            case .success(let response):
                completion(.success(response.results))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private let decoder = JSONDecoder()
    private let headers = [
        "x-rapidapi-host": "rawg-video-games-database.p.rapidapi.com",
        "x-rapidapi-key": "8e24dd9e5dmshb82b8dcc0df400ep1f2bc1jsn0e0a57afa70e"
    ]

    
    func getTopRatedContent(completion: @escaping (Result<[Content]>) -> Void) {
         
         var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games?dates=2010-01-01,2019-12-31&ordering=-rating")! as URL,
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
         
         var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&platforms=18,1,7")! as URL, cachePolicy: .useProtocolCachePolicy,
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
       
        var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games?dates=2010-01-01,2019-12-31&ordering=-added")! as URL,
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
    
    func getSearchedContent(title: String, completion: @escaping (Result<[Content]>) -> Void) {
        
        gameTitle = title
        
        var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games?search=\(gameTitle)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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
    
    func getDetails(id: Int, completion: @escaping (Result<Content>) -> Void) {
        
        gameId = id
        
        var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games/\(gameId)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers
         
        Alamofire
         .request(request)
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<Game>) in
                switch response.result {
                case .success(let response):
                    completion(.success(response.self))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func searchById(id: Int, completion: @escaping (Result<DBContent>) -> Void) {
        
        gameId = id
        
        var request = URLRequest(url: NSURL(string: "https://api.rawg.io/api/games/\(gameId)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers
         
        Alamofire
         .request(request)
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<DBContent>) in
                switch response.result {
                case .success(let response):
                    completion(.success(response.self))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

}
