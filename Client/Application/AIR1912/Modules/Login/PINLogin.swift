//
//  PINLogin.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit
import LoginPIN
import LocalAuthentication

class PINLogin: Login, LoginPINDelegate{
    
    func handleReturnedValue(isLogined: String, username email: String?, pass: String?) {
         if(isLogined == "true"){
                   pinIsConfirmed = true
                   if( bionicsSwitch) {
                       
                       handleBiometrics(viewController: viewController)
                   }else{goToHomeScreen()}
                  
               }
    }
    
    
    
    var pinIsConfirmed:Bool = false
    var viewController:UIViewController! = nil
    let bionicsSwitch = UserDefaults.standard.bool(forKey: "SwitchValue")
    
  
    
    
    func showLoginForm() -> UIViewController {
        let storyboard:UIStoryboard = UIStoryboard(name: "LoginPIN", bundle: Bundle(for: LoginPINViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginPIN") as! LoginPINViewController
        viewController = vc
        return vc
    }
    
    
    func handleBiometrics(viewController: UIViewController) {
        
        if(pinIsConfirmed){
            let context:LAContext = LAContext()
                          BiometricsHandler.handleFaceIDTouchID(viewController: viewController, context: context) { (complete) in
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
        
        
        
    }
    
    func setFormDelegate(viewController: UIViewController) {
        let vc = viewController as? LoginPINViewController
        vc!.delegate = self
    }
    
    
    func goToHomeScreen(){
           let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Homescreen", bundle: nil)
           let HomeController = HomeStoryboard.instantiateViewController(identifier: "HomeScreen") as! HomeSreenTabBarController
                      HomeController.modalPresentationStyle = .fullScreen
           self.viewController.present(HomeController, animated: true, completion: nil)
       }
    
    
    
}
