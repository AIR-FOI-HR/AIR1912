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


class BiometricsHandler{

    static public func handleFaceIDTouchID( vc:UIViewController)-> Bool{
        
        let context:LAContext = LAContext()
        var check:Bool = false
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to the door that we need to check your FaceID/TouchID") { (wasSuccessful, error) in
                if wasSuccessful{
                    check = true
                } else {
                    check = false
                }
            }
            
        } else {
           
        }
        return check
    }
}
