//
//  ImageBlur.swift
//  AIR1912
//
//  Created by Leo Leljak on 09/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

class ImageBlur {
    
    func blurImage(usingImage image:UIImage, blurAmount:CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image:image) else{
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        
        guard let outputImage = blurFilter?.outputImage else{
            return nil
        }
        return UIImage(ciImage: outputImage)
        
        
    }
}
