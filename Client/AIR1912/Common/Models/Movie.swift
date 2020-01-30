//
//  Movie.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

struct MovieResponse: Decodable {
    var page: Int
    var results: [Movie]
}

struct Movie: Decodable, Content {
    
    var type: ContentType {
        return .movie
    }
    var title: String?
    var id: Int
    var description: String?
    var poster: String?
    var year: String?
    var runtime: Int?
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(String(poster ?? "//www.google.com/url?sa=i&url=https%3A%2F%2Fwallpaperaccess.com%2Fplain-white&psig=AOvVaw3MICgrO5AkXB3D7Ht_U1rK&ust=1580068205972000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOip0_bCn-cCFQAAAAAdAAAAABAI"))")
    }
    var rating: Double?
    var genre: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case description = "overview"
        case poster = "poster_path"
        case year = "release_date"
        case runtime
        case rating = "vote_average"
        case genre = "genres"
    }
}

