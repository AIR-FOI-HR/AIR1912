//
//  ContentDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 18/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ContentDetailsController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var runTimeLbl: UILabel!
    @IBOutlet weak var descpriptionTv: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var joinbtn: UIButton!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var ratingLbl: UILabel!
    
    var id: Int = 0
    var type: ContentType = .game
    let cornerRadius : CGFloat = 12
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowView.layer.shadowRadius = 22.0
        shadowView.layer.shadowOpacity = 0.6
        
        
        frontImage.layer.cornerRadius = cornerRadius
        frontImage.clipsToBounds = true
        subView.layer.cornerRadius = 12
        configure(for: type)

        // Do any additional setup after loading the view.
    }
    
    func setBlurredImage(poster : URL?) {
        
        backImage.kf.setImage(with: poster)
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)
        
        
    }
    
    func configure(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        switch type {
        case .movie:
            provider.getDetails(id: id) { (result) in
                            switch result {
                            case .success(let podaci):
                                self.descpriptionTv.text = podaci.description
                                self.frontImage.kf.setImage(with: podaci.posterURL)
                                self.setBlurredImage(poster : podaci.posterURL)
                                let components = podaci.year?.split(separator: "-")
                                if(podaci.runtime != nil) {
                                    guard let runtime = podaci.runtime else { return }
                                    self.runTimeLbl.text = "· " + String(runtime) + " min" + " · 8.2 / 10 ·"
                                }
                                self.titleLbl!.text = podaci.title + " (" + (components?[0] ?? "-") + ")"
                                self.titleLbl.font = UIFont.boldSystemFont(ofSize: 24.0)
                            case .failure(_):
                                break
                            }
                        }
        case .game:
            provider.getDetails(id: id) { (result) in
                switch result {
                case .success(let podaci):
                    self.descpriptionTv.text = podaci.description
                    self.frontImage.kf.setImage(with: podaci.posterURL)
                    self.setBlurredImage(poster: podaci.posterURL)
                    let components = podaci.year?.split(separator: "-")
                    if(podaci.runtime != nil) {
                        guard let runtime = podaci.runtime else { return }
                        self.runTimeLbl.text = "· " + String(runtime) + " min" + " · 8.2 / 10 ·"
                    }
                    self.titleLbl!.text = podaci.title + " (" + (components?[0] ?? "-") + ")"
                    self.titleLbl.font = UIFont.boldSystemFont(ofSize: 24.0)
                case .failure(_):
                    break
                }
            }
        }
                
        }


}
