//
//  PassLogin.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import LoginPass
import UIKit
import LocalAuthentication


class PassLogin: Login, LoginPassDelegate  {
    
    var viewController:UIViewController! = nil
    var authService = AuthService()
    let userKeychain = UserKeychain()
    
    func handleReturnedValue(isLogined: String, username: String?, pass: String?) {
        if(isLogined == "true"){
            saveUserToKeychain(email: username!,pass: pass!)}
        else{
            let alerter = Alerter(title: "Credentials don't match any user in database", message: "Try again")
            alerter.alertError()
        }
    }
    
    
    func showLoginForm()->UIViewController{
        let storyboard:UIStoryboard = UIStoryboard(name: "LoginPass", bundle: Bundle(for: LoginPassViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPass") as! LoginPassViewController
        viewController = vc
        return vc
    }
    
    
    func saveUserToKeychain(email:String, pass:String) {
        let userKeychain = UserKeychain()
        
       
        UserDB.getUserFromDB(with: email, password: pass) { (result) in
            switch result {
            case .success(let user):
                _ = userKeychain.saveSessionData(email: email, password: pass, nickname: user[0].nickname, avatar: user[0].avatar.rawValue, id: Int(user[0].idUsers!)!, name: user[0].name, surname: user[0].surname)
                self.goToHomeScreen()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func handleBiometrics(viewController vc:UIViewController){
        let context:LAContext = LAContext()
        BiometricsHandler.handleFaceIDTouchID(viewController: vc, context: context) { (complete) in
            switch complete{
            case true:
                DispatchQueue.main.async {
                  self.goToHomeScreen()
                }
            case false:
                break
                
            }
        }
    }
    
    func setFormDelegate(viewController: UIViewController) {
           let vc = viewController as? LoginPassViewController
           vc!.delegate = self
       }
       
    
    
    
    func goToHomeScreen(){
        let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
        let HomeController = HomeStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
                   HomeController.modalPresentationStyle = .fullScreen
        self.viewController.present(HomeController, animated: true, completion: nil)
    }
    
}
