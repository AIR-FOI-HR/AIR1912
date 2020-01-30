//
//  FavouritesCollectionViewCell.swift
//  AIR1912
//
//  Created by Infinum on 17/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//


import UIKit
import Kingfisher

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    private let keychain = UserKeychain()
    private var userId:Int = 0
    
        
    override func prepareForReuse() {
        super.prepareForReuse()
        featuredImageView.image = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    
    func configure(with content: DBContent) {
        userId = keychain.getID()!
        titleName!.text = content.title
        let provider =  WebContentProvider()
        provider.getContentById(for: content.id!) { (result) in
            
                switch result {
                case .success(let podaci):
                    print (podaci)
                    self.featuredImageView.kf.setImage(with: URL(string: podaci[0].posterURL!))
                    
                case .failure(let error):
                    print("failure\(error)")
                    
                }
            }
    }
    
    
    private func setupView() {
        titleName.layer.cornerRadius = 6.0
        titleName.layer.masksToBounds = true
        featuredImageView.layer.cornerRadius = 12.0
        featuredImageView.layer.masksToBounds = true
        titleName.textColor = Theme.current.textColor
    }

}
