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


class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginSignView: UIView!
    @IBOutlet weak var loginButton: KBRoundedButton!
    @IBOutlet weak var signUpButton: KBRoundedButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var buttonOutlet: KBRoundedButton!
    @IBOutlet weak var buttonSignuUpOutlet: KBRoundedButton!
    
    // MARK - Properties
    
    private let authService: AuthService = AuthService()
    private let userKeychain: UserKeychain = UserKeychain()
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        additionalSetup()
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        additionalSetup()
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let loginStoryBoard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginController = loginStoryBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        loginController.modalPresentationStyle = .fullScreen
        self.present(loginController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        let signupStoryboard:UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupController = signupStoryboard.instantiateViewController(identifier:
            "SignupController") as! SignupController
        signupController.modalPresentationStyle = .fullScreen
        self.present(signupController, animated: true, completion: nil)
    }
}

extension MainViewController {
    
    private func additionalSetup(){
        
        loginSignView.layer.cornerRadius = 20
        print("View loadan")
        loadingActivity.isHidden = true
        tryToLoginFromUserDefaults()
    }
    
    func tryToLoginFromUserDefaults() {

        guard userKeychain.hasSessionData() else{
            return
        }
        loadingActivity.isHidden = false
        buttonOutlet.isHidden = true
        buttonSignuUpOutlet.isHidden = true
        loadingActivity.startAnimating()
        authService.login( with: userKeychain.getEmail()!, password: userKeychain.getPassword()!) { (result) in
            switch result {
            case .success(let user):
                self.showSuccessAlert(for: user)

            case .failure(let error):
                self.showErrorAlert(with: error)
            }

        
        }
    }
    
    private func showSuccessAlert(for user: [User]) {
        print("User postoji")
        if(user.isEmpty){
            let alertController: UIAlertController = UIAlertController(title: "User does not exist", message: "It is possible that user is deleted in meanwhile from database", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let HomeScreenStoryBoard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
            let HomeScreenController = HomeScreenStoryBoard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
            HomeScreenController.modalPresentationStyle = .fullScreen
            self.present(HomeScreenController, animated: true, completion: nil)
        }
    }
    
    private func showErrorAlert(with error: Error) {
        print("Error!\(error)")
    }
    
}

