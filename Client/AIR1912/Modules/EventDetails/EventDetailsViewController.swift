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

    
    
    @IBOutlet weak var cardView: SpringView!
    @IBOutlet weak var belowSubview: SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        belowSubview.isHidden = false
        
        
        cardView.isHidden = false
        cardView.animate()
        
        
    }
    
    
    func setBlurredImage() {
        
    }

}
