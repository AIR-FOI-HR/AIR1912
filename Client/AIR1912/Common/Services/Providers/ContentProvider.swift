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
    
    var title: String { get }
    var publisher: String { get }
}

protocol ContentProvider {
    
    func getTrendingContent(completion: @escaping (Result<[Content]>) -> Void)
}
