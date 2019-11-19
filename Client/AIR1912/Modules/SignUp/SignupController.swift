//
//  SignupController.swift
//  AIR1912
//
//  Created by Infinum on 19/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

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
        
        avatarSelection.layer.cornerRadius = 100
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
            
            let xPosition = self.view.frame.width * CGFloat(i)
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
    
    // TO DO: check confirmed password and add user to database
    @IBAction func buttonNext(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
