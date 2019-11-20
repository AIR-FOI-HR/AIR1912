//
//  ForgotPasswordVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 20/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
     @IBOutlet weak var viewContainer: UIView!
    
    //MARK: -Properties
    let recoverPassService = RecoverPassService()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius = 15
        //recoverPass()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRecoverPassword(_ sender: Any) {
        recoverPass()
        
    }
    
    private func recoverPass() {
        recoverPassService.recoverPassword(with: txtEmail.text!) { (result) in
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
            let alertController: UIAlertController = UIAlertController(title: "Sent to \(txtEmail.text!)", message: "Check your email", preferredStyle: .alert)
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

    @IBAction func btnCloseCurrent(_ sender: Any) {
        dismissContext()
    }
    
    func dismissContext() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
