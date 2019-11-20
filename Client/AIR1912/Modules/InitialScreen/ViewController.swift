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
        loginUser()
    }
}

extension ViewController {
    
    private func loginUser() {
        authService.login(with: "Leo") { (result) in
            switch result {
            case .success(let user):
                self.showSuccessAlert(for: user)
            case .failure(let error):
                self.showErrorAlert(with: error)
            }
        }
    }
    
    private func showSuccessAlert(for user: User) {
        print(user)
    }
    
    private func showErrorAlert(with error: Error) {
        print("Error!")
    }
}


