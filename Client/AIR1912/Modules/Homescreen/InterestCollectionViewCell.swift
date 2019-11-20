//
//  InterestCollectionViewCell.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var interest: Interest! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let interest = interest {
            featuredImageView.image = interest.featuredImage
        } else {
            featuredImageView = nil
        }
        
        featuredImageView.layer.cornerRadius = 10.0
        featuredImageView.layer.masksToBounds = true
    }
}
