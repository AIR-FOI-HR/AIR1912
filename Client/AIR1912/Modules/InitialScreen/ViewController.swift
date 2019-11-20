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
import CodableAlamofire
import Alamofire

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var LoginSignView: UIView!
    @IBOutlet weak var btnLogin: KBRoundedButton!
    @IBOutlet weak var btnSignUp: KBRoundedButton!
    @IBOutlet weak var txtWelcome: UILabel!
    
    // MARK - Properties
    
    private let authService: AuthService = AuthService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginSignView.layer.cornerRadius = 20
        //btnLogin.sizeToFit()
       // btnSignUp.sizeToFit()
       //txtWelcome.sizeToFit()
        
        // Do any additional setup after loading the view.
        
        
        

    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let loginSB:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "Login") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        let signupStoryboard:UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupController = signupStoryboard.instantiateViewController(identifier: "SignupController") as! SignupController
        signupController.modalPresentationStyle = .fullScreen
        self.present(signupController, animated: true, completion: nil)
    }
}

extension ViewController {
    
    
}


