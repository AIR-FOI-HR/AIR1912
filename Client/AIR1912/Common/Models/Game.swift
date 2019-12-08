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
    
    var title: String
    var description: String?
    var _poster: String?
    var year: String?
    //var genreId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "slug"
        case _poster = "background_image"
        case year = "released"
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
        //completion(nil)
    }
}
