//
//  EventDetailsViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 09/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Spring

class EventDetailsViewController: UIViewController {

    
    //MARK: -IBOutlets
    @IBOutlet weak var cardView: SpringView!
    @IBOutlet weak var belowSubview: SpringView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: -Properties
    let imageBlur = ImageBlur()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .clear
        setBlurredImage()
        belowSubview.isHidden = false
        
        cardView.isHidden = false
       // cardView.animate()
        
        
    }
    
    
    func setBlurredImage() {
        
        
        
        backgroundImage.image = UIImage(named: "testMovie")!
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        blur.frame = self.view.bounds
        self.view.insertSubview(blur, aboveSubview: backgroundImage)
        
    }

    
    @IBAction func swipeExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
