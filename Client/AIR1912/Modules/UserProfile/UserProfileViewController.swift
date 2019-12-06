//
//  UserProfileController.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    let keychain = UserKeychain()
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBAction func logoutButton(_ sender: Any) {
        logout()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set avatar from keychain
        let avatarValue = keychain.getAvatar()
        let avatar = Avatar(rawValue: avatarValue!)
        let userImage = avatar!.image

        userAvatar.image = userImage
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
