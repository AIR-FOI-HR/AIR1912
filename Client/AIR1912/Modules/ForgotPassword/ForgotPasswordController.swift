//
//  ForgotPasswordVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var emailTextView: UITextField!
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


extension ForgotPasswordController{
    
    private func additionalSetup(){
        
        containerView.layer.cornerRadius = 15
    }
    
    private func recoverPass() {
         recoverPassService.recoverPassword(with: emailTextView.text!) { (result) in
             switch result {
             case .success(let code):
                 self.showSuccessAlert(for: code)
             case .failure(let error):
                 self.showErrorAlert(with: error)
             }
         }
     }
     
     private func showSuccessAlert(for code: RecoverPassCodes) {
         if(code.code=="400"){
             let alertController: UIAlertController = UIAlertController(title: "Sent to \(emailTextView.text!)", message: "Check your email", preferredStyle: .alert)
             alertController.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: nil))
             self.present(alertController, animated: true, completion: nil)
             
         }
         else{
             let alertController: UIAlertController = UIAlertController(title: "Email is not found", message: "Check your email", preferredStyle: .alert)
             alertController.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: nil))
             self.present(alertController, animated: true, completion: nil)
         }
     }
     
     private func showErrorAlert(with error: Error) {
         print("Error!\(error)")
     }

    
     
     private func dismissContext() {
         self.dismiss(animated: true, completion: nil)
     }
    
    
    
}
