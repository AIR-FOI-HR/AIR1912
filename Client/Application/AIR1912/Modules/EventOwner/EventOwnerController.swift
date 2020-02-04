//
//  EventOwnerController.swift
//  AIR1912
//
//  Created by Infinum on 04/02/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class EventOwnerController: UIViewController {

    
    var eventOwner: User?
    
    // data to show
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nickname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        
    }
    
    func setData(){
        nickname.text = eventOwner?.nickname
        name.text = eventOwner?.name
        surname.text = eventOwner?.surname
        email.text = eventOwner?.email
        
        let avatarIcon = eventOwner?.avatar
        avatar.image = avatarIcon?.image
        
    }
    
    
    
    

    

}
