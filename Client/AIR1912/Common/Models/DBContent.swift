//
//  DBConcent.swift
//  AIR1912
//
//  Created by Infinum on 15/12/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation

struct DBContent: Decodable {
     var type: ContentType {
              return .movie
          }
          var title: String
          var sourceEntityId: Int
          var overview: String
          var poster_path: String
          var release_date: String?
          var runtime: Int?
          var posterURL: URL? {
              return URL(string: "https://image.tmdb.org/t/p/original\(poster_path)")
          }
}
