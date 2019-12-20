//
//  SettingsViewController.swift
//  AIR1912
//
//  Created by Infinum on 19/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let keychain = UserKeychain()
    
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {
        logout()
    }
    
    private func logout() -> Void{
        // delete stored data for user
        let dataIsDeleted = keychain.clearSessionData()
        if(!dataIsDeleted){
            let alerter = Alerter(title: "Oops", message: "Something went wrong with logout")
            alerter.alertError()
        }
        else{
            goToInitialScreen()
        }
    
}
    
    private func goToInitialScreen() -> Void{
        let InitialStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let InitialController = InitialStoryboard.instantiateViewController(identifier: "InitialScreen") as! MainViewController
        InitialController.modalPresentationStyle = .fullScreen
        self.present(InitialController, animated: true, completion: nil)
    }
}
