//
//  MapDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 28/01/2020.
//  Copyright © 2020 Infinum. All rights reserved.
//

import UIKit

class MapDetailsController: UIViewController {
 
    @IBOutlet weak var eventTitleTxt: UITextField!
    
    var selectedEvent: Event?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedEvent)
        
        displayEventDetails()
        // Do any additional setup after loading the view.
    }
    

    private func displayEventDetails(){
        eventTitleTxt.text = selectedEvent?.title
        
    }
}
