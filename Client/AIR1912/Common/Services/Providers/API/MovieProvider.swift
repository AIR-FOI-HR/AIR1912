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
    
    var movieId = Int()
    
    func getContentByIDFromDB(for id:Int, completion: @escaping (Result<[Content]>) -> Void) {
        Alamofire
        .request("https://cortex.foi.hr/meetup/ContentProvider.php?searchByID=\(id)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success(let response):
             
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
  
    
    
    private let API_KEY = "e965f161f0ec9f1c3931495b713226e0"
    
    private let decoder = JSONDecoder()
    
    var movieTitle = String()
    
    
    func getTopRatedContent(completion: @escaping (Result<[Content]>) -> Void) {
        
        Alamofire
        .request("https://api.themoviedb.org/3/movie/top_rated?api_key=\(API_KEY)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<MovieResponse>) in
            switch response.result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLatestContent(completion: @escaping (Result<[Content]>) -> Void) {
        
        Alamofire
        .request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<MovieResponse>) in
            switch response.result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPopularContent(completion: @escaping (Result<[Content]>) -> Void){
       
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
    
    func getSearchedContent(title: String, completion: @escaping (Result<[Content]>) -> Void) {
        
        movieTitle = title
        
        Alamofire
        .request("https://api.themoviedb.org/3/search/movie?api_key=\(API_KEY)&query=\(movieTitle)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<MovieResponse>) in
            switch response.result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetails(id: Int, completion: @escaping (Result<Content>) -> Void) {
         
        movieId = id
        
         Alamofire
         .request("https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(API_KEY)")
         .responseDecodableObject(decoder: decoder) { (response: DataResponse<Movie>) in
             switch response.result {
             case .success(let response):
                 completion(.success(response.self))
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }
}
