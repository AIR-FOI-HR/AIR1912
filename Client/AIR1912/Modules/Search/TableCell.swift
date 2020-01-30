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
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var ratingsLbl: UILabel!
    
    var contentId = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
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
        titleLbl.layer.cornerRadius = 4.0
        titleLbl.layer.masksToBounds = true
        genresLbl.layer.cornerRadius = 4.0
        genresLbl.layer.masksToBounds = true
        ratingsLbl.layer.cornerRadius = 4.0
        ratingsLbl.layer.masksToBounds = true
        imgView.layer.cornerRadius = 8.0
        imgView.layer.masksToBounds = true
        titleLbl.textColor = Theme.current.headingColor
        genresLbl.textColor = Theme.current.textColor
        ratingsLbl.textColor = Theme.current.textColor
        
    }
    
    
    private func getDetails(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        provider.getDetails(id: contentId) { (result) in
            switch result {
            case .success(let podaci):
                if(podaci.genre?.count != 0){
                    self.genresLbl.text = podaci.genre![0].name
                }
            case .failure(_):
                self.genresLbl.text = ""
        }
    }
}
    
    func configure(id: Int, with content: Content) {
        contentId = id
        getDetails(for: content.type)
        
        if let url = content.posterURL {
            self.imgView.kf.setImage(with: url)
            if (content.year != "") {
                let components = content.year?.split(separator: "-")
                 self.titleLbl!.text = content.title! + " (" + (components?[0] ?? "-") + ")"
            }
            else {
                self.titleLbl.text = content.title! + " (-)"
            }
           
            self.ratingsLbl.text = String(content.rating!)
        }
            
    }

}
    
