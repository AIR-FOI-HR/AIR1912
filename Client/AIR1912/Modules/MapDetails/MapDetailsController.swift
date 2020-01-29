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
    @IBOutlet weak var eventDateTimeTxt: UITextField!
    @IBOutlet weak var eventDescriptionTxt: UITextField!
    
    @IBOutlet weak var eventNumberOfPeopleTxt: UITextField!
    
    @IBAction func showMoreButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EventDetails", bundle: nil)
          guard let viewController = storyboard.instantiateViewController(identifier: "EventDetails") as? EventDetailsViewController else {
              return
          }
        
          viewController.modalPresentationStyle = .formSheet
          
          // na view controller detaljnog prikaza pridodaj odabrani event
        viewController.event = selectedEvent!
          
          self.present(viewController, animated: true, completion: nil)
    }
    
    var selectedEvent: Event?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayEventDetails()
        // Do any additional setup after loading the view.
    }
    

    private func displayEventDetails(){
        eventTitleTxt.text = selectedEvent?.title
        eventDateTimeTxt.text = selectedEvent?.dateTime
        eventDescriptionTxt.text = selectedEvent?.description
        if(selectedEvent?.numberOfPeople == nil){
            eventNumberOfPeopleTxt.text = "0"
        }
        else{
            eventNumberOfPeopleTxt.text = " \(String(describing: selectedEvent?.numberOfPeople))"
        }
        
        
        
        
    }
}
