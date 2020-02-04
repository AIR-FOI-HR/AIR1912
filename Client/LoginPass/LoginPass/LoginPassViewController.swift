//
//  LoginVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 11/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire
import KBRoundedButton
import LocalAuthentication
import Spring

let DB_URL = "https://cortex.foi.hr/meetup/AuthService.php"

public protocol LoginPassDelegate {
    func handleReturnedValue(isLogined:String,username:String?, pass:String?)
    
}

public class LoginPassViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var imageFaceID: UIImageView!
    @IBOutlet weak var buttonLogin: KBRoundedButton!
    @IBOutlet weak var buttonContent: SpringView!
    @IBOutlet weak var insertView: SpringView!
    //Properties
    public var delegate:LoginPassDelegate! = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
   
    @IBAction func loginButton(_ sender: Any) {
        let email = emailTextField.text
        let pass = passwordTextField.text
        
    
        Authentication.login(email: email!, password: pass!, DB_URL: DB_URL ) { (result) in
            switch result{
                case .success(let data):
                    self.delegate.handleReturnedValue(isLogined: data, username: email!, pass: pass! )
                
                case .failure (let error):
                    print(error)
            }
        }
    }
    
    
    
    
    
}
