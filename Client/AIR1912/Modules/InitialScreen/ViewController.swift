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

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var LoginSignView: UIView!
    @IBOutlet weak var btnLogin: KBRoundedButton!
    @IBOutlet weak var btnSignUp: KBRoundedButton!
    @IBOutlet weak var txtWelcome: UILabel!
    @IBOutlet weak var loadingAct: UIActivityIndicatorView!
    @IBOutlet weak var buttonOutlet: KBRoundedButton!
    @IBOutlet weak var buttonSignuUpOutlet: KBRoundedButton!
    
    // MARK - Properties
    
    private let authService: AuthService = AuthService()
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        LoginSignView.layer.cornerRadius = 20
        print("View loadan")
        loadingAct.isHidden = true
        
        
        //btnLogin.sizeToFit()
       // btnSignUp.sizeToFit()
       //txtWelcome.sizeToFit()
        
        // Do any additional setup after loading the view.
        
        
        

    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("preload")
        tryToLoginFromUserDefaults()
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let loginSB:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "Login") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        let signupStoryboard:UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupController = signupStoryboard.instantiateViewController(identifier: "SignupController") as! SignupController
        signupController.modalPresentationStyle = .fullScreen
        self.present(signupController, animated: true, completion: nil)
    }
}

extension ViewController {
    func tryToLoginFromUserDefaults() {
        print("trying...")
        var email:String = " "
        var pass:String = " "
        if let emailFromUD = UserDefaults.standard.string(forKey: "email") {
            email = emailFromUD
            print(email)
        }
        if let passFromUD = UserDefaults.standard.string(forKey: "pass") {
            pass = passFromUD
            print(pass)
        }
        
        if email != " " && pass != " " {
            loadingAct.isHidden = false
            buttonOutlet.isHidden = true
            buttonSignuUpOutlet.isHidden = true
            loadingAct.startAnimating()
            authService.login( with:email, password: pass ) { (result) in
                switch result {
                case .success(let user):
                    self.showSuccessAlert(for: user)
                    
                case .failure(let error):
                    self.showErrorAlert(with: error)
                }
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
            let HomeScreenSB:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
            let HomeScreenVC = HomeScreenSB.instantiateViewController(identifier: "HomeScreen") as! HomeScreenTBC
            HomeScreenVC.modalPresentationStyle = .fullScreen
            HomeScreenVC.currentUser = user[0]
            self.present(HomeScreenVC, animated: true, completion: nil)
        }
    }
    
    private func showErrorAlert(with error: Error) {
        print("Error!\(error)")
    }
    
}


