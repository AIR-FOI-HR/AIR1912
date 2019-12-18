//
//  ContentDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 18/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class ContentDetailsController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var YearLbl: UILabel!
    @IBOutlet weak var runTimeLbl: UILabel!
    @IBOutlet weak var descpriptionTv: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var joinbtn: UIButton!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    
    var id: Int = 0
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = type
        YearLbl.text = String(id)

        // Do any additional setup after loading the view.
    }
    

}
