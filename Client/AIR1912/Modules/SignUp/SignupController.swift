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
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassowordTxt: UITextField!
    
    
    
    @IBOutlet weak var avatarSelection: UIScrollView!
    
    var avatarImages = [UIImage]()
    
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
        avatarImages = [#imageLiteral(resourceName: "man-156584_1280"),#imageLiteral(resourceName: "teacher-359311_1280"),#imageLiteral(resourceName: "boy-38262_1280"),#imageLiteral(resourceName: "Logo")]
        
        for i in 0..<avatarImages.count{
            let imageView = UIImageView()
            imageView.image = avatarImages[i]
            
            let xPosition = self.avatarSelection.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.avatarSelection.frame.width, height: self.avatarSelection.frame.height)
            
            avatarSelection.contentSize.width = avatarSelection.frame.width * CGFloat(i + 1)
            avatarSelection.addSubview(imageView)
        }
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
        
        // Check if all fields are filled
        if nameTxt.text?.isEmpty ?? true || surnameTxt.text?.isEmpty ?? true || emailTxt.text?.isEmpty ?? true || passwordTxt.text?.isEmpty ?? true || confirmPassowordTxt.text?.isEmpty ?? true{
            
            showAlert("All fields have to be filled")
            //print("All fields have to be filled")
            readyToProceed = false
            
        }
        // Check if password and confirm password are the same
        var passwordsMatch:Bool = (passwordTxt.text == confirmPassowordTxt.text)
        if passwordsMatch == false{
            showAlert("Password and confirm password don't match")
            //print("Password and confirm password don't match")
            readyToProceed = false
        }
        
        if readyToProceed{
            addUser(nameTxt.text!, surnameTxt.text!, emailTxt.text!, passwordTxt.text!)
        }
        
    }
    
    func addUser(_ name:String,_ surname:String,_ email:String,_ password:String) -> Void{
        print("Ready to add user to database")
        
        // Define object User, use dictionary format and send to server as post method
        let newUser = UserPost(idUsers: nil, name: name, surname: surname, email: email, password: password)
        let newUserDict = newUser.dictonaryReturned
        Alamofire.request("http://air1912.000webhostapp.com/RegisterService.php", method: .post, parameters: newUserDict)
    }
    

    func showAlert(_ messageForDisplay:String) -> Void{
        let alertController = UIAlertController(title: "Something is wrong", message: messageForDisplay, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
