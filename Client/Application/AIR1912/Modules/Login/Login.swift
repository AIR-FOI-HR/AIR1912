//
//  Login.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

enum LoginType: String {
    case credentials = "credentials"
    case pin = "pin"
}

protocol Login{
    
    func tryToLogin(username:String?, password:String )
    func openLoginForm() -> UIViewController
    func handleBiometrics(viewController:UIViewController)
   
}