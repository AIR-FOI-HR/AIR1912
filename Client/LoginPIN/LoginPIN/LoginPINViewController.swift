//
//  LoginPINViewController.swift
//  LoginPIN
//
//  Created by Leo Leljak on 03/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Spring

public protocol LoginPINDelegate {
    func handleReturnedValue(isLogined:String,username:String?, pass:String?)
    
}


public class LoginPINViewController: UIViewController {
    @IBOutlet weak var textFieldPIN: SpringTextField!
    
    let userKeychain = UserKeychain()
    public var delegate:LoginPINDelegate? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        _ = userKeychain.savePIN(pin: "4443")
        textFieldPIN.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        textFieldPIN.becomeFirstResponder()
        getPIN()
        
    }
    
    
    func getPIN(){
        guard  userKeychain.getPIN() != nil else{
            return
        }
        
    }
   

}

extension LoginPINViewController: UITextViewDelegate{
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        print(textField.text)
        if(textFieldPIN.text!.count == 4){
            if(checkPIN()){
                delegate?.handleReturnedValue(isLogined: "true", username: nil, pass: nil)
            }
            else {textFieldPIN.text = ""
                textFieldPIN.animation = "shake"
                textFieldPIN.animate()
            }
        }
        
    }
    
    func checkPIN()->Bool{
        if (textFieldPIN.text! ==  userKeychain.getPIN()){
            return true
        }
        return false
    }
    
   
    
  
    
}
