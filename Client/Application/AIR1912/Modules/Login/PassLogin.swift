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
    
    func returnedParameters(username:String, pass:String) {
        //Provjera dal je dobra lozinka, -> prelazak na home screen
        tryToLogin(username: username, password: pass)
        
    }
    
    
    func openLoginForm()->UIViewController{
        let storyboard:UIStoryboard = UIStoryboard(name: "LoginPass", bundle: Bundle(for: LoginPassViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPass") as! LoginPassViewController
        viewController = vc
        vc.delegate = self
        return vc
    }
    
    
    func tryToLogin(username:String?, password:String) {
        let userKeychain = UserKeychain()
        
        guard let email = username else{
            return 
        }
        
        authService.login( with: email, password: password ) { (result) in
            switch result {
            case .success(let user):
                
                self.goToHomeScreen()
                       
                if(userKeychain.getEmail() != nil){
                    self.handleBiometrics(viewController: self.viewController)
                       } else {

                    _ = userKeychain.saveSessionData(email: email, password: password, nickname: user[0].nickname, avatar: user[0].avatar.rawValue, id: Int(user[0].idUsers!)!, name: user[0].name, surname: user[0].surname)
                       }
                
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
    
    
    
    func goToHomeScreen(){
        let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
        let HomeController = HomeStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
                   HomeController.modalPresentationStyle = .fullScreen
        self.viewController.present(HomeController, animated: true, completion: nil)
    }
    
}
