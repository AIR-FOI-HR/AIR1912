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
    
    //Mark: -IBOUTLETS
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    
    //Mark: -Properties
    
    //properties
    let keychain = UserKeychain()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        featuredImageView.image = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureForMyEvents(with event: Event) {
            
        titleName!.text = event.title
        let provider =  WebContentProvider()
        provider.getContentById(for: event.contentID){(result) in
                switch result {
                case .success(let podaci):
                    print (podaci)
                    self.featuredImageView.kf.setImage(with: URL(string: podaci[0].posterURL!))
                    
                case .failure(let error):
                    print("failure\(error)")
                    
                }
            }
    }
    
    func configureForNearEvents(with event: Event) {
        setupView()
        
        titleName!.text = event.title
        let provider = WebContentProvider()
        provider.getContentById(for: event.contentID){(result) in
               switch result {
               case .success(let podaci):
                   print (podaci)
                   self.featuredImageView.kf.setImage(with: URL(string: podaci[0].posterURL!))
                    
                   
               case .failure(let error):
                   print(print(error))
                   
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
    
    private func isNear()->Bool{
        return true
        
        
        
    }
    
}
