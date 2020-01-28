//
//  EditAccountViewController.swift
//  AIR1912
//
//  Created by Infinum on 28/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

class EditAccountViewController: UIViewController {
    @IBOutlet weak var nicknameTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var cpassTxt: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    private let keychain:UserKeychain = UserKeychain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshUserData()

    }
    
    func refreshUserData(){
        let userNickname = self.keychain.getNickname()
        self.nicknameTxt.placeholder = userNickname
           
        let userName = self.keychain.getName()
        self.nameTxt.placeholder = userName
           
        let userSurname = self.keychain.getSurname()
        self.surnameTxt.placeholder = userSurname
           
        let userEmail = self.keychain.getEmail()
        self.emailTxt.placeholder = userEmail
    }
    func updateUserData() {
        let nickname = nicknameTxt.text
        let name = nameTxt.text
        let surname = surnameTxt.text
        let email = emailTxt.text
        let password = passTxt.text
        
        let updatedUser = User(nickname: nickname, idUsers: id, name: name, surname: surname, email: email, password: password, avatar: <#T##Avatar#>)
        
        AuthService.update(user: updatedUser)
        switch result {
        case .success(let user):
            self.updateUserData(with: user)
            self.refreshUserData()
        case .failure(_):
            let alerter = Alerter(title: "Error", message: "Something went wrong")
        }
    }
    
    func updateUserData(user: User) {
        // Updateaj podatke u keychainu za usera
        
    }
}
