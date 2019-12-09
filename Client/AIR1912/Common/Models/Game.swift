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
    var poster: String
    var year: String?
    //var genreId: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "slug"
        case poster = "background_image"
        case year = "released"
        //case genreId = "category"
    }
    
    func getPosterURL(completion: @escaping (URL?) -> Void) {
        let url = URL(string: poster)
        completion(url)
    }
}
