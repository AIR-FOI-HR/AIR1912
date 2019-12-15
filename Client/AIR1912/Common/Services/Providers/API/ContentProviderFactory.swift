//
//  ContentProviderFactory.swift
//  AIR1912
//
//  Created by Infinum on 12/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

class ContentProviderFactory {
    static func contentProvider(forContentType contentType: ContentType) -> ContentProvider {
      switch contentType {
      case .game:
          return GameProvider()
      case .movie:
         return MovieProvider()
      }
   }
}
