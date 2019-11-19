//
//  HomeScreenVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 19/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblWelcomeMessage: UILabel!
    
    //MARK: - Properties
    var currentUser:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = currentUser?.name {
            lblWelcomeMessage.text = "Hello \(text)"}
        // Do any additional setup after loading the view.
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
