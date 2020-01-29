//
//  LoginVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 11/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire
import KBRoundedButton
import LocalAuthentication

let API_URL = "http://air1912.000webhostapp.com/service.php"


class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var upContentView: UIView!
    @IBOutlet weak var logInButton: KBRoundedButton!
    
    @IBOutlet weak var faceIDButton: UIButton!
    // MARK: - Properties
    private let authService: AuthService = AuthService()
    private let userKeychain: UserKeychain = UserKeychain()
    private var startContentInset:CGFloat = CGFloat()
    private var startScrollIndicatorInset:CGFloat = CGFloat()
    private var emailTextFieldIsActive:Bool = false
    private var passwordTextFieldIsActive:Bool = false
    private var scrollViewWasChanged:Bool = false
    
    //MARK: -
    
    
    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        userloginUser()
        
        
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
       
           let RecoverPasswordStoryBoard: UIStoryboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
           let RecoverPsaswordController = RecoverPasswordStoryBoard.instantiateViewController(identifier: "ForgotPassword") as! ForgotPasswordViewController
           RecoverPsaswordController.modalPresentationStyle = .overCurrentContext
           self.present(RecoverPsaswordController, animated: true, completion: nil)
           
       }
    
    @IBAction func faceIDLogIn(_ sender: Any) {
        handleFaceIDTouchID()
    }
    
}


extension LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        upContentView.backgroundColor = ThemesManager.shared.theme.baseColor
        logInButton.backgroundColor = ThemesManager.shared.theme.baseColor
        
        startScrollIndicatorInset = scrollView.verticalScrollIndicatorInsets.bottom
        
        startContentInset = scrollView.contentInset.bottom
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleFaceIDTouchID() {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to the door that we need to check your FaceID/TouchID") { (wasSuccessful, error) in
                if wasSuccessful{
                    DispatchQueue.main.async {
                        self.biometricLoginUser()
                    }
                } else {
                    DispatchQueue.main.async {
                        let alerter = Alerter(title: "Incorrect credentials", message: "Please try again")
                        alerter.alertError()
                    }
                }
            }
            
        } else {
            let alerter = Alerter(title: "FaceID/TouchID not configured", message: "Please go to device settings")
            alerter.alertError()
        }
    }
    
 
    private func biometricLoginUser() {
        let email = self.userKeychain.getEmail()!
        let password = self.userKeychain.getPassword()!
        login(email: email, password: password)
    }
    
    private func userloginUser() {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            let alerter = Alerter(title: "Some fields missing", message: "Insert value into all fields")
            alerter.alertError()
            return
        }
        login(email: email, password: password)
    }
    
    private func login(email: String, password: String) {
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
           
        _ = userKeychain.saveSessionData(email: emailTextField.text!, password: passwordTextField.text!, nickname: user[0].nickname, avatar: user[0].avatar.rawValue, id: Int(user[0].idUsers!)!)
    }
    
    private func showErrorAlert(with error: ResponseError) {
        let alerter = Alerter(title: error.title, message: error.message)
        alerter.alertError()
    }
    
   func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
     guard
       let userInfo = notification.userInfo,
       let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
         as? NSValue
       else {
         return
     }
    let adjustmentHeight = (keyboardFrame.cgRectValue.height + 100)
    print(adjustmentHeight)
    switch scrollViewWasChanged {
    case true: break
    case false:
        print("promjena")
           
        scrollView.contentInset.bottom = adjustmentHeight
        scrollView.verticalScrollIndicatorInsets.bottom = adjustmentHeight
            scrollViewWasChanged = true
    }
    
}
     
   
   @objc func keyboardWillShow(_ notification: Notification) {
     
        if(emailTextField.isFirstResponder){
            emailTextFieldIsActive = true
        }else {emailTextFieldIsActive = false }
        
        if(passwordTextField.isFirstResponder){
            passwordTextFieldIsActive = true
        }else { passwordTextFieldIsActive = false}
        adjustInsetForKeyboardShow(true, notification: notification)
    
    
    }
   @objc func keyboardWillHide(_ notification: Notification) {
     adjustInsetForKeyboardShow(false, notification: notification)
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            textField.resignFirstResponder()
            userloginUser()
        
        default:
            break
        }
        return true
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        scrollView.contentInset.bottom = -401
        scrollView.verticalScrollIndicatorInsets.bottom = -401
        scrollViewWasChanged = false
    }
    
    
}
