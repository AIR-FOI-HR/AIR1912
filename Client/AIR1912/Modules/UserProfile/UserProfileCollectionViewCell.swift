//
//  UserProfileCollectionViewCell.swift
//  AIR1912
//
//  Created by Infinum on 19/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher

class UserProfileCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    
    //MARK: - Private properties
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
           super.prepareForReuse()
           featuredImageView.image = nil
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureForMyEvents(with event: Event) {
               
           eventTitle!.text = event.title
           let provider = WebContentProvider()
           provider.getContentById(for: event.contentID){(result) in
                   switch result {
                   case .success(let podaci):
                       print (podaci)
                       self.featuredImageView.kf.setImage(with: URL(string: podaci[0].posterURL!))
                       
                   case .failure(_):
                       print("failure")
                       
                   }
            }
       }
    
       
       private func setupView() {
        eventTitle.layer.cornerRadius = 6.0
        eventTitle.layer.masksToBounds = true
           featuredImageView.layer.cornerRadius = 12.0
           featuredImageView.layer.masksToBounds = true
 
       }
       
}
