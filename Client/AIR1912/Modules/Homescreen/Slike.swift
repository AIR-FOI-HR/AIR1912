//
//  Slike.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class Slike
{
    var featuredImage: UIImage
    
    init(featuredImage: UIImage) {
        self.featuredImage = featuredImage
    }
    
    static func dohvatiSliku() -> [Slike]
    {
        return [
            Slike (featuredImage: UIImage(named: "s1")!),
            Slike (featuredImage: UIImage(named: "s2")!),
            Slike (featuredImage: UIImage(named: "s3")!),
            Slike (featuredImage: UIImage(named: "s4")!)
        ]
    }
}
