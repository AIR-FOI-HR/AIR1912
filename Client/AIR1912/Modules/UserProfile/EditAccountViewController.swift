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
    
    @IBOutlet weak var avatarSelection: UIScrollView!
       
    var avatarImages = [UIImage]()
    let alerter = Alerter(title: "Something went wrong", message: "There seems to be an issue with that")
    
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
        
        avatarImages = Avatar.allCases.map { $0.image }
        
        for i in 0..<avatarImages.count{
            let imageView = UIImageView()
            imageView.image = avatarImages[i]
            
            let xPosition = self.avatarSelection.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.avatarSelection.frame.width, height: self.avatarSelection.frame.height)
            
            avatarSelection.contentSize.width = avatarSelection.frame.width * CGFloat(i + 1)
            avatarSelection.addSubview(imageView)
        }
    }
    func updateUserData() {
        let nickname = nicknameTxt.text!
        let name = nameTxt.text!
        let surname = surnameTxt.text!
        let email = emailTxt.text!
        let password = passTxt.text!
        let avatar = currentAvatar()
        let id = String(keychain.getID()!)
        
        let updatedUser = User(nickname: nickname, idUsers: id,
                               name: name, surname: surname, email: email,
                               password: password, avatar: avatar)
        
        updateUserInDatabase(user: updatedUser)
        
    }
    
    private func updateUserInDatabase(user: User){
        print(user.idUsers!)
        let registerService: RegisterService = RegisterService()
            registerService.updateUser(with: user) { (result) in
                switch result {
                case .success(let user):
                    print("user updatean")
                    self.updateUserDataInKeychain(user: user)
        
                case .failure(let error):
                    self.showRegisterError(error)
                }
            }
    }
    
    private func showRegisterError(_ error:Error) -> Void{
          let responseError = error as! ResponseError
          let alerter = Alerter(responseError: responseError)
          let alertController = alerter.getUIAlertController()
          self.present(alertController, animated: true, completion: nil)
      }
    
    func currentAvatar() -> Avatar {
        let allCases = Avatar.allCases // all avatars from enum
        let currentOffsetX = avatarSelection.contentOffset.x // content offset in avatar selection
        guard currentOffsetX != 0 else { return allCases[0] } // if offset is 0, first image is selected
        let currentIndex = Int(currentOffsetX / avatarSelection.frame.width)
        return allCases[currentIndex] // selected avatar
    }
    
    func updateUserDataInKeychain(user: User) {
        // Updateaj podatke u keychainu za usera
        
    }
    
    @IBAction func saveButton(_ sender: Any){
        var readyToProceed = true
        if (passTxt.text == cpassTxt.text) == false{
            alerter.title = "Sorry"
            alerter.message = "Passwords don't match"
            self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
            readyToProceed = false
            
        }
        
        if  nicknameTxt.text?.isEmpty ?? true || nameTxt.text?.isEmpty ?? true || surnameTxt.text?.isEmpty ??
            true || emailTxt.text?.isEmpty ?? true || passTxt.text?.isEmpty ?? true
            || cpassTxt.text?.isEmpty ?? true{
            
            alerter.title = "Sorry"
            alerter.message = "All fields have to be filled"
            self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
            readyToProceed = false
            
        }
        if readyToProceed{
            let selectedAvatar = currentAvatar()
            self.updateUserData()
        }
        
        
}
}
