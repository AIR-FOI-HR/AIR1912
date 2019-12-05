//
//  Alerter.swift
//  AIR1912
//
//  Created by Infinum on 30/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

class Alerter{
    
    var title: String
    var message: String
    let alerter: SCLAlertView
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
        self.alerter = SCLAlertView()
    }

    convenience init(responseError: ResponseError) {
        self.init(title: responseError.title, message: responseError.message)
    }

    func getUIAlertController() -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        return alertController
    }
    
    func alertError(){
        alerter.showError(title, subTitle: message)
    }
    
    func alertWarning(){
        alerter.showWarning(title, subTitle: message)
    }
    
    func alertSuccess(){
        alerter.showSuccess(title, subTitle: message)
    }
    
    //todo: postepeno dodavati funkcije oko alerta koje budu nam potrebne
    //pogledati SCLAlertView dokumentaciju sa svim mogućnostima (dodavanje gumbova na alert itd...)

}
