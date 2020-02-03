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
import LoginPIN
import LoginPass


class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginSignView: UIView!
    @IBOutlet weak var loginButton: KBRoundedButton!
    @IBOutlet weak var signUpButton: KBRoundedButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var buttonOutlet: KBRoundedButton!
    @IBOutlet weak var buttonSignuUpOutlet: KBRoundedButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK - Properties
    
    private let authService: AuthService = AuthService()
    private let userKeychain: UserKeychain = UserKeychain()
    private var bionicsSwitch:Bool = false
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
    
        self.view.backgroundColor = Theme.current.headingColor
        buttonOutlet.backgroundColorForStateNormal = Theme.current.headingColor
        buttonSignuUpOutlet.backgroundColorForStateNormal = Theme.current.headingColor
        
        let pinSwitch = UserDefaults.standard.bool(forKey: "PINSwitch")
        bionicsSwitch = UserDefaults.standard.bool(forKey: "SwitchValue")
        
        switch pinSwitch {
        case true:
            if(userKeychain.getEmail() != nil ){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.login(loginType: .pin)
                    
                }
            }else{
                tryToLoginFromKeychain()
            }
        case false:
            if(userKeychain.getEmail() != nil && bionicsSwitch){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.login(loginType: .credentials)
                    
                }
            }else{
                tryToLoginFromKeychain()
            }
        }
    
        additionalSetup()
        
    }
    
    
    
    @IBAction func btnLogin(_ sender: Any) {
        self.login(loginType: .credentials)
        
        
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
    
    private func login(loginType:LoginType){
        let loginer = LoginFactory.loginProvider(forLoginType: loginType)
        let viewController = loginer.showLoginForm()
        self.present(viewController, animated: true, completion: nil)
        switch(bionicsSwitch){
            case true:
                loginer.handleBiometrics(viewController: viewController)
            case false:
                break
        }
        
    }
    
    private func additionalSetup(){
        
        loginSignView.layer.cornerRadius = 20
        print("View loadan")
        loadingActivity.isHidden = true
        
    }
   
    
    func tryToLoginFromKeychain() {

        guard let email = userKeychain.getEmail() else{
            return
        }


        loadingActivity.isHidden = false
        buttonOutlet.isHidden = true
        buttonSignuUpOutlet.isHidden = true
        loadingActivity.startAnimating()
        
       authService.login( with: userKeychain.getEmail()!, password: userKeychain.getPassword()!) { (result) in
            switch result {
            case .success(let user):
                print(user)
                self.goToHomeScreen()

            case .failure(let error):

                self.loadingActivity.isHidden = true
                self.buttonOutlet.isHidden = false
                self.buttonSignuUpOutlet.isHidden = false
                self.loadingActivity.stopAnimating()


            }
        }
    }
    
    private func goToHomeScreen() {
       
        let LoginStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
        let LoginviewController = LoginStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
        LoginviewController.modalPresentationStyle = .fullScreen
        self.present(LoginviewController, animated: true, completion: nil)
        
    }
    
   
    
}


