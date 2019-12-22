//
//  DateTimePickerViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 22/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

protocol DateTimePickerDelegate {
    func setDateTime(dateTime:Date)
}

class DateTimePickerViewController: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    //MARK: - Properties
    var delegate:DateTimePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func setDateTime(_ sender: Any) {
        delegate?.setDateTime(dateTime: dateTimePicker!.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
