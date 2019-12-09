//
//  InterestCollectionViewCell.swift
//  AIR1912
//
//  Created by Infinum on 01/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher

class InterestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
        
    override func prepareForReuse() {
        super.prepareForReuse()
        featuredImageView.image = nil
    }
    
    func configure(with content: Content) {
        setupView()        
        if let url = content.posterURL {
            self.featuredImageView.kf.setImage(with: url)
        }

    }
    
    private func setupView() {
        featuredImageView.layer.cornerRadius = 12.0
        featuredImageView.layer.masksToBounds = true
    }
}

