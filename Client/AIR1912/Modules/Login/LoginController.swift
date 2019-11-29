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


class LoginController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    
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
           let RecoverPsaswordController = RecoverPasswordStoryBoard.instantiateViewController(identifier: "ForgotPassword") as! ForgotPasswordController
           RecoverPsaswordController.modalPresentationStyle = .overCurrentContext
           self.present(RecoverPsaswordController, animated: true, completion: nil)
           
       }

}


extension LoginController {
    
    private func loginUser() {
        authService.login( with:nameTextView.text!, password: passwordTextView.text! ) { (result) in
            switch result {
            case .success(let user):
                self.showSuccessAlert(for: user)
                
            case .failure(let error):
                self.showErrorAlert(with: error)
            }
        }
    }
    
    private func showSuccessAlert(for user: [User]) {
        if(user.isEmpty){
            let alertController: UIAlertController = UIAlertController(title: "User does not exist", message: "Check your username and password combination. If you Forgot password, try to recover it with designated button.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        else{
            let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
            let HomeController = HomeStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
            HomeController.modalPresentationStyle = .fullScreen
            self.present(HomeController, animated: true, completion: nil)
            
            //TODO: User defaults
//            UserDefaults.standard.set(nameTextView.text!, forKey: "email")
//            UserDefaults.standard.set(passwordTextView.text!, forKey: "pass")
            //dodano u keychain
            _ = userKeychain.saveData(email: nameTextView.text!, password: passwordTextView.text!)
            
        }
    }
    
    private func showErrorAlert(with error: Error) {
        print("Error!\(error)")
    }
    
    
}
