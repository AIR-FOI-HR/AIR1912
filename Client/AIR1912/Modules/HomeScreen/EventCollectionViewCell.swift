//
//  EventCollectionViewCell.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import CoreLocation
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
        
    
    //properties
    let keychain = UserKeychain()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        featuredImageView.image = nil
        
    }
    
    func configureForMyEvents(with event: Event) {
        setupView()
            
        titleName!.text = event.title
        let provider = DBMovieProvider()
        provider.getContentByID(for: event.contentID){(result) in
                switch result {
                case .success(let podaci):
                    print (podaci)
                    self.featuredImageView.kf.setImage(with: podaci[0].posterURL)
                    
                case .failure(_):
                    print("failure")
                    
                }
            }
    }
    
    func configureForNearEvents(with event: Event) {
        setupView()
        
        
    
        
        titleName!.text = event.title
        let provider = DBMovieProvider()
        provider.getContentByID(for: event.contentID){(result) in
               switch result {
               case .success(let podaci):
                   print (podaci)
                   self.featuredImageView.kf.setImage(with: podaci[0].posterURL)
                    
                   
               case .failure(_):
                   print("failure")
                   
                }
            }
        }
    
    
    
    private func setupView() {
        featuredImageView.layer.cornerRadius = 12.0
        featuredImageView.layer.masksToBounds = true
    }
    
    private func isNear()->Bool{
        return true
        
        
        
    }
    
}
