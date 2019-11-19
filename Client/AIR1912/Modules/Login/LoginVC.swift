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


class LoginVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    // MARK: - Properties
    private let authService: AuthService = AuthService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        loginUser()
        
        
    }
    
    private func loginUser() {
        authService.login( with:txtName.text!, password: txtPassword.text! ) { (result) in
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
            let HomeScreenSB:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
            let HomeScreenVC = HomeScreenSB.instantiateViewController(identifier: "HomeScreen") as! HomeScreenVC
            HomeScreenVC.modalPresentationStyle = .fullScreen
            HomeScreenVC.currentUser = user[0]
            self.present(HomeScreenVC, animated: true, completion: nil)
        }
    }
    
    private func showErrorAlert(with error: Error) {
        print("Error!\(error)")
    }
    
    
    
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        //TODO: Forgot Password Implementation
        
    }
    
    
}
