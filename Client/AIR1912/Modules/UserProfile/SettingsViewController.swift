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

    
    @IBOutlet weak var biometricsSwitch: UISwitch!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var accountLabel: UIButton!
    @IBOutlet weak var themesLabel: UIButton!
    @IBOutlet weak var faceIDLabel: UIButton!
    @IBOutlet weak var notificationLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        biometricsSwitch.setOn(UserDefaults.standard.bool(forKey: "SwitchValue"), animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        accountLabel.setTitleColor(Theme.current.headingColor, for: .normal)
        themesLabel.setTitleColor(Theme.current.headingColor, for: .normal)
        faceIDLabel.setTitleColor(Theme.current.headingColor, for: .normal)
    notificationLabel.setTitleColor(Theme.current.headingColor, for: .normal)
        logoutButton.setTitleColor(Theme.current.headingColor, for: .normal)
        biometricsSwitch.onTintColor = Theme.current.headingColor
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func biometricsSettings(_ sender: Any) {
        if(biometricsSwitch.isOn){
            UserDefaults.standard.set(true, forKey: "SwitchValue")
        } else {
            UserDefaults.standard.set(false, forKey: "SwitchValue")
        }
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
