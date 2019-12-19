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
    
    var id: Int
    var title: String
    var description: String?
    var poster: String
    var year: String? 
    var runtime: Int?
    var posterURL: URL? {
        return URL(string: poster)
    }
    var rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "description_raw"
        case poster = "background_image"
        case year = "released"
        case id = "id"
        case runtime = "playtime"
        case rating
    }
    
}

struct DBGame: Content, Decodable{
    
    var type: ContentType {
           return .game
       }
       
       var id: Int
       var title: String
       var description: String?
       var poster: String
       var year: String?
       var runtime: Int?
       var posterURL: URL? {
           return URL(string: poster)
       }
       var rating: Double
       
       enum CodingKeys: String, CodingKey {
           case title = "name"
           case description = "slug"
           case poster = "background_image"
           case year = "released"
           case id = "sourceEntityId"
           case runtime = "playtime"
           case rating
       }
}
