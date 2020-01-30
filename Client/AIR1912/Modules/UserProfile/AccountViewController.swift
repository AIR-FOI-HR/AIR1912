//
//  AccountViewController.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

class AccountViewController: UIViewController {
    
    @IBOutlet weak var nicknameTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    private let keychain:UserKeychain = UserKeychain()
    

    override func viewDidLoad() {
            super.viewDidLoad()
            
            // set avatar from keychain
            
            let avatarValue = self.keychain.getAvatar()
            let avatar = Avatar(rawValue: avatarValue!)
            let userImage = avatar!.image

            self.userAvatar.image = userImage
            
            let userNickname = self.keychain.getNickname()
            self.nicknameTxt.text = userNickname!
        
            let userName = self.keychain.getName()
            self.nameTxt.text = userName
        
            let userSurname = self.keychain.getSurname()
            self.surnameTxt.text = userSurname
        
            let userEmail = self.keychain.getEmail()
            self.emailTxt.text = userEmail
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        editButton.setTitleColor(Theme.current.headingColor, for: .normal)
        nameTxt.textColor = Theme.current.headingColor
        nicknameTxt.textColor = Theme.current.headingColor
        surnameTxt.textColor = Theme.current.headingColor
        emailTxt.textColor = Theme.current.headingColor
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
