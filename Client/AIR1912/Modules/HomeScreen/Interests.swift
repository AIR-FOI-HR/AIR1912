//
//  Interests.swift
//  AIR1912
//
//  Created by Infinum on 01/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher


class Interest
{
    var featuredImage: URL
    private static let movieProvider: MovieProvider = MovieProvider()
    init(featuredImage: URL) {
        self.featuredImage = featuredImage
    }
    
    
//    static func fetchInterests() -> [Interest]
//    {
//        var contentArray = [Interest]()
//        movieProvider.getTrendingContent { (result) in
//            switch result {
//            case .success(let podaci):
//                for element in podaci{
//                    print("https://image.tmdb.org/t/p/original\(element.poster)")
//                    contentArray.append(Interest(featuredImage: URL(string: "https://image.tmdb.org/t/p/original\(element.poster)")!))
//                }
//                
//            case .failure(let error):
//                print(error)
//            }
//            print("-----------------")
//            print(contentArray)
//        }
//        print("-------------------")
//        print(contentArray)
//        return contentArray
//    }
}
