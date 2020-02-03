//
//  BiometricsHandler.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit


public class BiometricsHandler{
    
    static public func handleFaceIDTouchID( viewController:UIViewController, context:LAContext, completion: @escaping(Bool)-> Void)->Void{
        
        let vc:LoginPassViewController = viewController as! LoginPassViewController
        vc.emailTextField.isHidden = true
        vc.passwordTextField.isHidden = true
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to the door that we need to check your FaceID/TouchID") { (wasSuccessful, error) in
                if wasSuccessful{
                    completion(true)
                } else {
                    completion(false)
                }
            }
            
        } else {
           
        }
        
        
    }
}
