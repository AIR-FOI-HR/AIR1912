//
//  Alerter.swift
//  AIR1912
//
//  Created by Infinum on 30/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

class Alerter{
    
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    func getUIAlertController() -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        return alertController;
    }

}
