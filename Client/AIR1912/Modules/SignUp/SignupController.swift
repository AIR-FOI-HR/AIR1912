//
//  SignupController.swift
//  AIR1912
//
//  Created by Infinum on 19/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire

class SignupController: UIViewController {
    
    @IBOutlet weak var nicknameTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassowordTxt: UITextField!
    
    
    
    @IBOutlet weak var avatarSelection: UIScrollView!
    
    var avatarImages = [UIImage]()
    
    // alerter object - to be used if alert is needed
    let alerter = Alerter(title: "Something went wrong", message: "There seems to be an issue with that")
    
    // register service
    private let registerService: RegisterService = RegisterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //avatarSelection.layer.cornerRadius = 100
        // Txt fields to be passed from one to another
        nameTxt.delegate = self as? UITextFieldDelegate
        nameTxt.tag = 0
        
        surnameTxt.delegate = self as? UITextFieldDelegate
        surnameTxt.tag = 1
        
        emailTxt.delegate = self as? UITextFieldDelegate
        emailTxt.tag = 2
        
        passwordTxt.delegate = self as? UITextFieldDelegate
        passwordTxt.tag = 3
        
        confirmPassowordTxt.delegate = self as? UITextFieldDelegate
        confirmPassowordTxt.tag = 4
        
        //images to choose from
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
    
    func currentAvatar() -> Avatar {
        let allCases = Avatar.allCases // all avatars from enum
        let currentOffsetX = avatarSelection.contentOffset.x // content offset in avatar selection
        guard currentOffsetX != 0 else { return allCases[0] } // if offset is 0, first image is selected
        let currentIndex = Int(currentOffsetX / avatarSelection.frame.width)
        return allCases[currentIndex] // selected avatar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //if next field exists, make it first reponser
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        
        // if next field does not exist, close keyboard
        else{
            textField.resignFirstResponder()
        }
        
        // Return
        return false
    }
    
    // On button pressed
    @IBAction func buttonNext(_ sender: Any) {
        var readyToProceed = true
        
        let avatar = currentAvatar()
        avatar.rawValue
        
        // Check if all fields are filled
        if  nicknameTxt.text?.isEmpty ?? true || nameTxt.text?.isEmpty ?? true || surnameTxt.text?.isEmpty ?? true || emailTxt.text?.isEmpty ?? true || passwordTxt.text?.isEmpty ?? true || confirmPassowordTxt.text?.isEmpty ?? true{
            
            alerter.title = "Sorry"
            alerter.message = "All fields have to be filled"
            self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
            readyToProceed = false
            
        }
        // Check if password and confirm password are the same
        if (passwordTxt.text == confirmPassowordTxt.text) == false{
            alerter.title = "Sorry"
            alerter.message = "Passwords don't match"
            self.present(alerter.getUIAlertController(), animated: true, completion: nil)
            
            readyToProceed = false
        }
        
        if readyToProceed{
            let selectedAvatar = currentAvatar()
            let newUser = User(nickname: nicknameTxt.text!, idUsers: nil,name: nameTxt.text!,surname: surnameTxt.text!, email: emailTxt.text!, password: passwordTxt.text!) //avatar:selectedAvatar
            
            addUser(newUser)
        }
        
    }
    
    private func addUser(_ newUser:User) -> Void{
    
        registerService.register(with: newUser) { (result) in
            switch result {
            case .success(let user):
                self.addUserDataToKeychain(user)
    
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
    
    private func addUserDataToKeychain(_ user: User) -> Void{
        let keychain = UserKeychain()
        var clearedKeychain = keychain.clearSessionData()
        
        if(clearedKeychain == false){
            print("we messed up")
        }
        else{
            keychain.saveSessionData(email: user.email, password: user.password, nickname: user.nickname, avatar: "man")
            goToHomescreen()
        }
        
    }
    
    private func goToHomescreen() -> Void{
        let HomeStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let HomeController = HomeStoryboard.instantiateViewController(identifier: "InitialScreen") as! HomeSreenTabBarController
        HomeController.modalPresentationStyle = .fullScreen
        self.present(HomeController, animated: true, completion: nil)
    }
    

}
