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



public protocol LoginPassDelegate {
    func returnedParameters(username:String, pass:String)
    
}

public class LoginPassViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Properties
    public var delegate:LoginPassDelegate! = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
   
    @IBAction func loginButton(_ sender: Any) {
        let email = emailTextField.text
        let pass = passwordTextField.text
        
        delegate!.returnedParameters(username: email!, pass: pass!)
    }
    
    
    
    
    
}
