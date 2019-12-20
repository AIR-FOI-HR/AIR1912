//
//  ContentDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 18/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ContentDetailsController: UIViewController {

    //MARK: - Outlets
    
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
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var descriptionHeadlineLbl: UILabel!
    
    //MARK: - Properties
    
    var id: Int = 0
    var type: ContentType = .game
    let cornerRadius : CGFloat = 12
    var genreName = ""
    

    //MARK: - Lifecycle

    override func viewDidLoad() {
    super.viewDidLoad()
    setShadowView()
    configure(for: type)


     }
    func setShadowView() {
        
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowView.layer.shadowRadius = 22.0
        shadowView.layer.shadowOpacity = 0.6
        
        frontImage.layer.cornerRadius = cornerRadius
        frontImage.clipsToBounds = true
        subView.layer.cornerRadius = 12
    }
    
    func setBlurredImage(poster : URL?) {
        
        backImage.kf.setImage(with: poster)
        let darkBlur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)
        
        
    }
    
    func setUpView(for Content: Content) {
        
        //self.genresLbl.text = "Action · Fantasy · Horror"
        self.descpriptionTv.text = Content.description
        self.frontImage.kf.setImage(with: Content.posterURL)
        self.setBlurredImage(poster : Content.posterURL)
        let components = Content.year?.split(separator: "-")
        if(Content.runtime != nil) {
            guard let runtime = Content.runtime else { return }
            self.lengthLbl.text = String(runtime) + " min"
        }
        self.yearLbl.text = String(components?[0] ?? "-")
        self.ratingLbl.text = String(Content.rating)
        self.titleLbl!.text = Content.title
    }
    
    func getGenre(for Content: Content) {
        var genreName = ""
        var brojac = 0
        if (Content.genre!.count <= 3){
            for item in (Content.genre)! {
                brojac += 1
                if(brojac <= (Content.genre!.count-1)) {
                    genreName += item.name! + " · "
                } else {
                genreName += item.name!
                }
            }
            
        }else{
            genreName += Content.genre![0].name! + " · " + Content.genre![1].name! + " · " + Content.genre![2].name!
        }
        self.genresLbl.text = genreName
    }
    
    func configure(for type: ContentType) {
        
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
        switch type {
        case .movie:
            self.descriptionHeadlineLbl.text = "Synopsis"
            provider.getDetails(id: id) { (result) in
                            switch result {
                            case .success(let podaci):
                                self.getGenre(for: podaci)
                                self.setUpView(for: podaci)
                            case .failure(_):
                                break
                            }
                        }
        case .game:
            self.descriptionHeadlineLbl.text = "Overview"
            provider.getDetails(id: id) { (result) in
                switch result {
                case .success(let podaci):
                    self.getGenre(for: podaci)
                    self.setUpView(for: podaci)
                case .failure(_):
                    break
                }
                
            }
            
        }
                
    }

}
