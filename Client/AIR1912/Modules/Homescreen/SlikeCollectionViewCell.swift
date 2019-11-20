//
//  SlikeCollectionViewCell.swift
//  AIR1912
//
//  Created by Infinum on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class SlikeCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var slike: Slike! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let slike = slike 
    }
}
