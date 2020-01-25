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
    var title: String?
    var description: String?
    var poster: String?
    var year: String? 
    var runtime: Int?
    var posterURL: URL? {
        return URL(string: poster ?? "/www.google.com/url?sa=i&url=https%3A%2F%2Fwallpaperaccess.com%2Fplain-white&psig=AOvVaw3MICgrO5AkXB3D7Ht_U1rK&ust=1580068205972000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOip0_bCn-cCFQAAAAAdAAAAABAI")
    }
    var rating: Double?
    var genre: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "description_raw"
        case poster = "background_image"
        case year = "released"
        case id = "id"
        case runtime = "playtime"
        case rating
        case genre = "genres"
    }
    
}

