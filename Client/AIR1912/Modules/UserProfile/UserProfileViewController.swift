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
    @IBOutlet weak var nicknameText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //let gameEventProvider = PublicEventProvider()
//        gameEventProvider.getAllEvents{ (result) in
//            switch result {
//            case .success(let podaci):
//                print("podaci su \(podaci)")
//            case .failure(_):
//               print("failure")
//            }
//        }
        
        // set avatar from keychain
        let avatarValue = keychain.getAvatar()
        let avatar = Avatar(rawValue: avatarValue!)
        let userImage = avatar!.image

        userAvatar.image = userImage
        
        // set welcome message with nickname
        let userNickname = keychain.getNickname()
        nicknameText.text = "Hi " + userNickname!
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
    
    @IBAction func testEventDetails(_ sender: Any) {
        
        let EventDetailsStoryboard:UIStoryboard = UIStoryboard(name: "EventDetails", bundle: nil)
        let EventDetailsViewController = EventDetailsStoryboard.instantiateViewController(identifier: "EventDetails") as! EventDetailsViewController
        EventDetailsViewController.modalPresentationStyle = .fullScreen
        self.present(EventDetailsViewController, animated: true, completion: nil)
        
        
    }
}
