//
//  DBConcent.swift
//  AIR1912
//
//  Created by Infinum on 15/12/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation

struct DBContent: Decodable, Encodable {
          var id:Int?
          var type: String?
          var title: String
          var sourceEntityId: Int
          var overview: String
          var poster_path: String
          var release_date: String?
          var runtime: Int?
          var posterURL: String?
    
    init(content:Content, type:ContentType) {
        self.type = type.rawValue
        self.title = content.title!
        self.sourceEntityId = content.id
        self.overview = content.description!
        self.poster_path = content.poster!
        self.release_date = content.year
        self.runtime = content.runtime
        self.posterURL = content.posterURL?.absoluteString
    }
}
