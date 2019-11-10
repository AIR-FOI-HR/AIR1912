//
//  ViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 08/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Spring
import KBRoundedButton

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var LoginSignView: UIView!
    
    @IBOutlet weak var btnLogin: KBRoundedButton!
    
    @IBOutlet weak var btnSignUp: KBRoundedButton!
    
    @IBOutlet weak var txtWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginSignView.layer.cornerRadius = 20
        //btnLogin.sizeToFit()
       // btnSignUp.sizeToFit()
       //txtWelcome.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
    
    
    

}

