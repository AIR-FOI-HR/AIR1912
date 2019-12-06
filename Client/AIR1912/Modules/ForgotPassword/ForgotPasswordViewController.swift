//
//  ForgotPasswordVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: -Properties
    let recoverPassService = RecoverPassService()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSetup()
    }
    
    @IBAction func recoverPasswordClicked(_ sender: Any) {
        recoverPass()
        
    }
    
    @IBAction func closeCurrentClick(_ sender: Any) {
           dismissContext()
       }
    
}


extension ForgotPasswordViewController{
    
    private func additionalSetup(){
        
        containerView.layer.cornerRadius = 15
    }
    
    private func recoverPass() {
         recoverPassService.recoverPassword(with: emailTextField.text!) { (result) in
             switch result {
             case .success(let user):
                 self.showSuccessAlert(for: user)
             case .failure(let error):
                 self.showErrorAlert(with: error as! ResponseError)
             }
         }
     }
     
     private func showSuccessAlert(for user: User) {
        let alerter = Alerter(title: "Sent to \(user.email)", message: "Check your email")
        alerter.alertSuccess()
     }
     
     private func showErrorAlert(with error: ResponseError) {
        let alerter = Alerter(title: "Email is not found", message: "Check email/nickname you've inserted")
        alerter.alertError()
     }

    
     
     private func dismissContext() {
         self.dismiss(animated: true, completion: nil)
     }
    
    
    
}
