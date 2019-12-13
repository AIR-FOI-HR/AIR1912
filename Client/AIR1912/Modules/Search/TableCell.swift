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
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    
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
    }
    
    func configure(with content: Content) {
        setupView()
        
        if let url = content.posterURL {
            self.imgView.kf.setImage(with: url)
            titleLbl!.text = content.title
            descriptionTxtField.text = content.description
            
        }

    }

}
