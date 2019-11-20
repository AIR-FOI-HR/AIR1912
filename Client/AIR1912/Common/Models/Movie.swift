//
//  Movie.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    var page: Int
    var results: [Movie]
}

struct Movie: Decodable, Content {
    var type: String {
        return "movie"
    }
    var title: String
    var description: String?
    var poster: String
    var year: String
    //var genreId: [Int]
    var runtime: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "overview"
        case poster = "poster_path"
        case year = "release_date"
        //case genreId = "genre_ids"
        case runtime
        
    }
}