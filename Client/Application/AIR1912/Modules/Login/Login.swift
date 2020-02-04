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
    
    
    func showLoginForm() -> UIViewController
    func setFormDelegate(viewController:UIViewController) -> Void
    func handleReturnedValue(isLogined:String, username email:String?, pass:String?)
    func handleBiometrics(viewController:UIViewController)
    func goToHomeScreen() -> Void
}
