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
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
    
        self.view.backgroundColor = Theme.current.headingColor
        buttonOutlet.backgroundColorForStateNormal = Theme.current.headingColor
        buttonSignuUpOutlet.backgroundColorForStateNormal = Theme.current.headingColor
        
        let pinSwitch = UserDefaults.standard.bool(forKey: "PINSwitch")
        let bionicsSwitch = UserDefaults.standard.bool(forKey: "SwitchValue")
        
        switch pinSwitch {
        case true:
            break
        case false:
            if(userKeychain.getEmail() != nil && bionicsSwitch){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.login(loginType: .credentials)
                }
            }else{
                tryToLoginFromKeychain()
            }
        }
    
        additionalSetup()
        
    }
    
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        
        
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
        let viewController = loginer.openLoginForm() as! LoginPassViewController
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    private func additionalSetup(){
        
        loginSignView.layer.cornerRadius = 20
        print("View loadan")
        loadingActivity.isHidden = true
        
       
        
        
    }
    func goToFaceTouchIDLogin(){
         
        let passLogin = PassLogin()
        let viewController = passLogin.openLoginForm() as! LoginPassViewController
        self.present(viewController, animated: true, completion: nil)
        
        
    }
    
    func tryToLoginFromKeychain() {

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
                print(user)
                self.showSuccessAlert(for: user)

            case .failure(let error):

                self.loadingActivity.isHidden = true
                self.buttonOutlet.isHidden = false
                self.buttonSignuUpOutlet.isHidden = false
                self.loadingActivity.stopAnimating()


                // if you are offline, error is not set because error
                // is expected to return from server
                // therefore, we have to check if we got error
                // if we didn't, we should create new errorResponse
                // and set title and message for offline case
                var errorIsEmpty = false
                if(error == nil){
                    errorIsEmpty = true
                }
                guard errorIsEmpty else {
                    print("Something is wrong")

                    return
                }
                // cannot be shown if there is no error set
                self.showErrorAlert(with: error as! ResponseError)
            }
        }
    }
    
    private func showSuccessAlert(for user: [User]) {
       
        let LoginStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
        let LoginviewController = LoginStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
        LoginviewController.modalPresentationStyle = .fullScreen
        self.present(LoginviewController, animated: true, completion: nil)
        
    }
    
    private func showErrorAlert(with error: ResponseError) {
        let alerter = Alerter(title: error.title, message: error.message)
        alerter.alertError()
        print("Trebalo bi stati")
        loadingActivity.isHidden = true
        buttonOutlet.isHidden = false
        buttonSignuUpOutlet.isHidden = false
    }
    
}


