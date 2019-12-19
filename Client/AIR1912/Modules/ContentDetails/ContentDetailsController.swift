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
    @IBOutlet weak var YearLbl: UILabel!
    @IBOutlet weak var runTimeLbl: UILabel!
    @IBOutlet weak var descpriptionTv: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var joinbtn: UIButton!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var subView: UIView!
    
    var id: Int = 0
    var type: ContentType = .game
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontImage.layer.cornerRadius = 12
        subView.layer.cornerRadius = 12
        configure()

        // Do any additional setup after loading the view.
    }
    
    func setBlurredImage(poster : URL?) {
        
        backImage.kf.setImage(with: poster)
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)
        
        
    }
    
        func configure() {
    
            if (type == .movie) {
                let provider = MovieProvider()
                provider.getDetails(id: id) { (result) in
                    switch result {
                    case .success(let podaci):
                        self.descpriptionTv.text = podaci.description
                        self.frontImage.kf.setImage(with: podaci.posterURL)
                        self.setBlurredImage(poster : podaci.posterURL)
                        let components = podaci.year?.split(separator: "-")
                        self.YearLbl.text = String(components?[0] ?? "-")
                        if(podaci.runtime != nil) {
                            guard let runtime = podaci.runtime else { return }
                            self.runTimeLbl.text = String(runtime)
                        }
                        self.titleLbl!.text = podaci.title
                    case .failure(_):
                        break
                    }
    
                    }
            } else if (type == .game){
                    let provider = GameProvider()
                    provider.getDetails(id: id) { (result) in
                        switch result {
                        case .success(let podaci):
                            self.descpriptionTv.text = podaci.description
                            self.frontImage.kf.setImage(with: podaci.posterURL)
                            self.setBlurredImage(poster: podaci.posterURL)
                            let components = podaci.year?.split(separator: "-")
                            self.YearLbl.text = String(components?[0] ?? "-")
                            if(podaci.runtime != nil) {
                                guard let runtime = podaci.runtime else { return }
                                self.runTimeLbl.text = String(runtime)
                            }
                            self.titleLbl!.text = podaci.title
                        case .failure(_):
                            break
                        }
                    }
    
                }
                
        }


}
