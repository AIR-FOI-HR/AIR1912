//
//  Game.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

struct GameResponse: Decodable {
    var results: [Game]
}

struct Game: Decodable, Content {
    
    var type: ContentType {
        return .game
    }
    var title: String {
        return _title ?? "Unknown"
    }
    private var _title: String?
    var description: String?
    var _poster: Int?
    var year: String?
    //var genreId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case _title = "name"
        case description = "summary"
        case _poster = "cover"
        case year = "release_date"
        //case genreId = "category"
    }
    
    func getPosterURL(completion: @escaping (URL?) -> Void) {
        //Alamofire
         //   .request(URL(string: "")!)
          //  .responseDecodableObject { (result) in
            //    switch result {
              //  case .success(let object):
              //      let url = object.url
              //      completion(url)
             //   case .failure:
              //      completion(nil)
               // }
        //}
        completion(nil)
    }
}
