//
//  MovieProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

enum MovieError:Error {
    case noDataAvailable
    case canNotProcessData
}

class MovieRequest {
    let resourceURL:URL
    let API_KEY = "e965f161f0ec9f1c3931495b713226e0"
    
    init() {
        let resourceString = "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getMovies (completion: @escaping(Result<[Movie], MovieError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL){ data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: jsonData)
                //let movieDetails = movieResponse.response.self
                //completion(.success([movieDetails]))
                print("hello")
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
        
    }
    
    
    
    
}















//import Alamofire

//class MovieProvider: ContentProvider {
    
//    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void) {
//       let decoder = JSONDecoder()
//        Alamofire
//            .request("http://air1912.000webhostapp.com/service.php?name=Leo")
//            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Movie]>) in
//                switch response.result {
//                case .success(let movies):
//                    completion(.success(movies))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//}
