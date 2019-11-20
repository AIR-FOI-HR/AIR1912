//
//  Interets.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class Interest
{
    var featuredImage: UIImage
    
    init(featuredImage: UIImage) {
        self.featuredImage = featuredImage
    }
    
    
    static func fetchInterests() -> [Interest]
    {
        return [
            Interest(featuredImage: UIImage(named: "s1")!),
            Interest(featuredImage: UIImage(named: "s2")!),
            Interest(featuredImage: UIImage(named: "s3")!),
            Interest(featuredImage: UIImage(named: "s4")!)
        ]
    }
}
