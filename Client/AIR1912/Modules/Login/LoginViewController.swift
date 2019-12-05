//
//  LoginVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 11/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire


let API_URL = "http://air1912.000webhostapp.com/service.php"


class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Properties
    private let authService: AuthService = AuthService()
    private let userKeychain: UserKeychain = UserKeychain()
    
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        loginUser()
        
        
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
       
           let RecoverPasswordStoryBoard: UIStoryboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
           let RecoverPsaswordController = RecoverPasswordStoryBoard.instantiateViewController(identifier: "ForgotPassword") as! ForgotPasswordViewController
           RecoverPsaswordController.modalPresentationStyle = .overCurrentContext
           self.present(RecoverPsaswordController, animated: true, completion: nil)
           
       }

}


extension LoginViewController {
    
    private func loginUser() {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            let alerter = Alerter(title: "Some fields missing", message: "Insert value into all fields")
            alerter.alertError()
            return
            
        }
        
        authService.login( with: email, password: password ) { (result) in
            switch result {
            case .success(let user):
                self.showSuccessAlert(for: user)
                
            case .failure(let error):
                self.showErrorAlert(with: error as! ResponseError)
            }
        }
    }
    
    private func showSuccessAlert(for user: [User]) {
            let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
            let HomeController = HomeStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
            HomeController.modalPresentationStyle = .fullScreen
            self.present(HomeController, animated: true, completion: nil)
           
        _ = userKeychain.saveSessionData(email: emailTextField.text!, password: passwordTextField.text!, nickname: user[0].nickname, avatar: "bezveze")
    }
    
    private func showErrorAlert(with error: ResponseError) {
        let alerter = Alerter(title: error.title, message: error.message)
        alerter.alertError()
    }
    
    
}
