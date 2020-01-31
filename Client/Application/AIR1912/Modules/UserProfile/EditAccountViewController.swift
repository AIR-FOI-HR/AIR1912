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
    
    @IBOutlet weak var avatarSelection: UIScrollView!
       
    var avatarImages = [UIImage]()
    let alerter = Alerter(title: "Something went wrong", message: "There seems to be an issue with that")
    
    private let keychain:UserKeychain = UserKeychain()
    private let updateUser:RegisterService = RegisterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshUserData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        nicknameTxt.textColor = Theme.current.headingColor
        nameTxt.textColor = Theme.current.headingColor
        surnameTxt.textColor = Theme.current.headingColor
        emailTxt.textColor = Theme.current.headingColor
        passTxt.textColor = Theme.current.headingColor
        cpassTxt.textColor = Theme.current.headingColor
        saveButton.setTitleColor(Theme.current.headingColor, for: .normal)
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func refreshUserData(){
        
        _ = self.keychain.getNickname()
        //self.nicknameTxt.text = userNickname
           
        _ = self.keychain.getName()
        //self.nameTxt.placeholder = userName
           
        _ = self.keychain.getSurname()
        //self.surnameTxt.placeholder = userSurname
           
        _ = self.keychain.getEmail()
            //self.emailTxt.placeholder = userEmail
        _ = self.keychain.getPassword()
        //self.passTxt.text = pass
        //self.cpassTxt.text = pass
        
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
                    print("User updatean")
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
        
        _ = keychain.saveSessionData(email: emailTxt.text!, password: passTxt.text!, nickname: nicknameTxt.text!, avatar: currentAvatar().rawValue, id: keychain.getID()!, name: nameTxt.text!, surname: surnameTxt.text!)
        
    }
    
    @IBAction func saveButton(_ sender: Any){
        var readyToProceed = true
        if (passTxt.text == cpassTxt.text) == false{
            alerter.title = "Sorry"
            alerter.message = "Passwords don't match"
            self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
            readyToProceed = false
            
        }
        if nicknameTxt.text?.isEmpty ?? true {
            let nickname = self.keychain.getNickname()
            self.nicknameTxt.text = nickname
        }
        if nameTxt.text?.isEmpty ?? true {
            let name = self.keychain.getName()
            self.nameTxt.text = name
        }
        if surnameTxt.text?.isEmpty ?? true {
            let surname = self.keychain.getSurname()
            self.surnameTxt.text = surname
        }
        if emailTxt.text?.isEmpty ?? true {
            let email = self.keychain.getEmail()
            self.emailTxt.text = email
        }
        if passTxt.text?.isEmpty ?? true {
            let pass = self.keychain.getPassword()
            self.passTxt.text = pass
            self.cpassTxt.text = pass
        }
        if readyToProceed{
        
        updateUserData()
            _ = navigationController?.popViewController(animated: true)
            
            
//        alerter.title = "Success"
//        alerter.message = "You have successfully updated your profile!"
//        self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
        let UserProfileStoryboard:UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let UserProfileController = UserProfileStoryboard.instantiateViewController(identifier: "UserProfile") as! UserProfileViewController
        UserProfileController.modalPresentationStyle = .fullScreen
        self.present(UserProfileController, animated: true, completion: nil)
            

            
        
        }

        
}
}
