//
//  ViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 08/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Spring
import KBRoundedButton
import CodableAlamofire
import Alamofire

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var LoginSignView: UIView!
    
    @IBOutlet weak var btnLogin: KBRoundedButton!
    
    @IBOutlet weak var btnSignUp: KBRoundedButton!
    
    @IBOutlet weak var txtWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginSignView.layer.cornerRadius = 20
        //btnLogin.sizeToFit()
       // btnSignUp.sizeToFit()
       //txtWelcome.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let decoder=JSONDecoder()
        Alamofire.request("http://air1912.000webhostapp.com/service.php?name=Leo").responseDecodableObject(decoder: decoder) { (response: DataResponse<[User]>) in
            switch response.result {
            case .success(let users):
                print(users[0].email)
            case .failure(let error):
                let alertController = UIAlertController(title: "Dogodio se error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        
    }
    

}

