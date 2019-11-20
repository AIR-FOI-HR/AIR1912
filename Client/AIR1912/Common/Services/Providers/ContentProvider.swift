//
//  ContentProvider.swift
//  AIR1912
//
//  Created by Infinum on 14/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire

protocol Content {
    
    var type: String { get }
    var title: String { get }
    var description: String? { get }
    var publisher: String? { get }
    var poster:String { get }
}

protocol ContentProvider {
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void)
}
