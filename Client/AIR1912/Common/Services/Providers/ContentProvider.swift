//
//  ContentProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

enum ContentType: String {
    case game = "game"
    case movie = "movie"
}

protocol Content {
    
    var type: ContentType { get }
    var title: String { get }
    var description: String? { get }
//    var poster:String { get }
    
    func getPosterURL(completion: @escaping (URL?) -> Void)
}

protocol ContentProvider {
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void)
}
