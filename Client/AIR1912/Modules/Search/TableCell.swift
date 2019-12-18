//
//  TableCell.swift
//  AIR1912
//
//  Created by Infinum on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTv: UITextView!
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        imgView.layer.cornerRadius = 12.0
        imgView.layer.masksToBounds = true
        descriptionTv.textContainer.maximumNumberOfLines = 3
        descriptionTv.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    
    func configure(with content: Content) {
        setupView()

        if let url = content.posterURL {
            if (content.type == ContentType.movie) {
            descriptionTv.text = content.description
            self.imgView.kf.setImage(with: url)
            let components = content.year?.split(separator: "-")
            titleLbl!.text = content.title + " (" + (components?[0] ?? "-") + ")"
            }else {
                let provider = GameProvider()
                provider.getDetails(id: content.id) { (result) in
                    switch result {
                    case .success(let podaci):
                        self.descriptionTv.text = podaci.description
                    case .failure(_):
                        break
                    }
                }
                self.imgView.kf.setImage(with: url)
                let components = content.year?.split(separator: "-")
                titleLbl!.text = content.title + " (" + (components?[0] ?? "-") + ")"
                
            }
            
        }

    }
    
    
}
