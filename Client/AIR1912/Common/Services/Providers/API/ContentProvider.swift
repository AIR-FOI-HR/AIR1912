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
    
    var id: Int { get }
    var type: ContentType { get }
    var title: String { get }
    var description: String? { get }
    var poster: String { get }
    var posterURL: URL? { get }
    var runtime: Int? { get }
    var year: String? { get }
    
}

protocol ContentProvider {
    
    func getPopularContent(completion: @escaping (Result<[Content]>) -> Void)
    
    func getTopRatedContent(completion: @escaping (Result<[Content]>) -> Void)
    
    func getLatestContent(completion: @escaping (Result<[Content]>) -> Void)
    
    func getSearchedContent(title: String, completion: @escaping (Result<[Content]>) -> Void)
    
    func getDetails(id: Int, completion: @escaping (Result<Content>) -> Void)
    
}
