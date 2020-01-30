//
//  EventDetailsViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 28/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit
import CoreLocation
import KBRoundedButton
import Floaty
import SCLAlertView

protocol EventDetailsDelegate{
    func didHideView()
}

class EventDetailsViewController: UIViewController {
    
    //iboutlets
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var lockEvent: UIImageView!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelNameOfDay: UILabel!
    @IBOutlet weak var labelLocation1: UILabel!
    @IBOutlet weak var textLocation2: UITextView!
    @IBOutlet weak var labelNumver: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    
    @IBOutlet weak var buttonJoin: KBRoundedButton!
    @IBOutlet weak var floatyButton: Floaty!
    
    @IBOutlet weak var labelButtonName: UILabel!
    
    
    //properties
    var event:Event = Event()
    let cornerRadius : CGFloat = 12
    let keychain = UserKeychain()
    var delegate:EventDetailsDelegate! = nil
    var userAttending:Bool = false
    let webProvider = WebEventProvider()
    let webHandler = WebEventHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setShadowView()
        configure()
        
       
        floatyButton.verticalDirection = .down
        floatyButton.buttonColor =  UIColor(hex:  "97FFA8")
    
        let update = FloatyItem()
        update.icon = UIImage(named: "update")
        update.buttonColor = UIColor(hex:  "97FFA8")
        update.imageSize = CGSize(width: 20, height: 20)
        update.handler = {item in self.goToEventCRUD(floaty: update)}
        floatyButton.addItem(item: update)
        
        let trash = FloatyItem()
        trash.icon = UIImage(named: "trash")
        trash.buttonColor = UIColor(hex:  "FF1306")
        trash.handler = {item in self.deleteEvent(floaty: trash)}
        floatyButton.addItem(item: trash)
        
    }
    
    @IBAction func buttonJoinLeave(_ sender: Any) {
        
        if(userAttending){
           print("Leave")
            tryToLeaveEvent()
        }else{
             print("Join")
            tryToJoinEvent()
        }
        
    }
    
    

}

//Initial set
extension EventDetailsViewController{
    func setShadowView() {
        
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowView.layer.shadowRadius = 22.0
        shadowView.layer.shadowOpacity = 0.6
      
        frontImage.layer.cornerRadius = cornerRadius
        frontImage.clipsToBounds = true
        subView.layer.cornerRadius = 12
     
    }
    
    func setBlurredImage(poster : URL?) {
        
        backImage.kf.setImage(with: poster)
        let darkBlur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backImage.bounds
        backImage.addSubview(blurView)
        
    }
    
    func setUpView(for content: DBContent) {
        self.frontImage.kf.setImage(with: URL(string:  content.posterURL!))
        self.setBlurredImage(poster: URL(string:  content.posterURL!))
        
    }
    
    func configure(){
        
        if(event.isPrivate==1){
            confIfPrivate()
        }
        if(event.ownerId == keychain.getID() ){
            self.floatyButton.isHidden = false
        }
        checkIfUserIsJoined()
        
        let ContentProvider = WebContentProvider()
        ContentProvider.getContentById(for: event.contentID) { (result) in
            switch (result){
            case .success(let content):
                self.setUpView(for: content[0])
                self.eventType.text = content[0].type
            case .failure( _):
                    print("Nije nađen content u bazi")
                    
            }
        }
        
        self.titleEvent.text = event.title
        
        if(event.isPrivate==1){
            lockEvent.isHidden = false
        }
        print (event.dateTime as Any)
        let dateFromString = FormatDate.getDateFromWebDBString(date: event.dateTime)
        let day = FormatDate.getNameOfDayFromDate(date: dateFromString)
        let nameOfMonth = FormatDate.getNameOfMonthFromDate(date: dateFromString)
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day, .hour, .minute, .year], from: dateFromString! as Date)
        
        
        let dayOfMonth = comp.day
        labelDay.text = "\(dayOfMonth!).\(nameOfMonth!)"
        labelNameOfDay.text = "\(day!)"
        
        
        let hour = comp.hour
        let minute = comp.minute
        labelTime.text = "\(hour!):\(minute!)"
       
        geocode(latitude: event.latitude, longitude: event.longitude) { placemark, error in
            guard let placemark = placemark, error == nil else { return }
            
            DispatchQueue.main.async {
                
                self.textLocation2.text = placemark.thoroughfare ?? ""
            }
        }
        
        self.textDescription.text = event.description
        
        let maxNumber = event.maxNumberOfPeople
        var currentNumber = 0
        if(event.numberOfPeople != nil){
            currentNumber = event.numberOfPeople!
        }
        self.labelNumver.text = "\(currentNumber)/\(maxNumber)"
        
        

        
        
       
        
        
        
        
        
        
        
     
        
    }
    
}

extension EventDetailsViewController{
    
    func checkIfUserIsJoined(){
        let webProvider = WebEventProvider()
        webProvider.getEventsByUserID(for: keychain.getID()!, eventType: .allEvent) { (result) in
            switch result{
                case .success(let events):
                    for eventsAttending in events{
                        print("EventiNaKojima: \(eventsAttending.id)")
                        if(eventsAttending.id == self.event.id){
                            self.buttonJoin.titleLabel?.textColor = .white
                            self.labelButtonName.text = "Leave"
                            self.userAttending = true
                            
                            
                        }
                        if(!self.userAttending){
                            self.confIfUserNotAttending();
                        }
                        
                    }
                case .failure(_):
                    print("Failure in getting User events")
            }
        }
    }
    
    func confIfUserNotAttending(){
        self.labelButtonName.text = "Join"
        userAttending = false

    }
    
    func confIfPrivate(){
        buttonJoin.backgroundColorForStateNormal = UIColor(hex: "FF1306")
        shadowView.backgroundColor = UIColor(hex: "FF1306").withAlphaComponent(0.55)
        
    }
  
    func geocode(latitude: Double , longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
               CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
           }
    
    func goToEventCRUD(floaty:FloatyItem){
        let CRUDStoryBoard:UIStoryboard = UIStoryboard(name: "EventCRUD", bundle: nil)
        let CRUDController = CRUDStoryBoard.instantiateViewController(identifier: "EventCRUD") as! EventCRUDViewController
        CRUDController.event = self.event
        CRUDController.delegate = self
        self.present(CRUDController, animated: true, completion: nil)
    }
    
    func deleteEvent(floaty:FloatyItem){
        
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Yes") {
            let webEventHandler = WebEventHandler()
            webEventHandler.deleteEvent(for: self.event.id) { (result) in
                switch result{
                case .success(let variable):
                    let alert = Alerter(title: "You've successfully deleted Event", message: "Event is no longer available")
                    alert.alertSuccess()
                    self.delegate.didHideView()
                    self.dismiss(animated: true, completion: nil)
                    
                case .failure(_):
                    print("failure")
                }
            }
        }
        alertView.addButton("No") {
            alertView.hideView()
        }
        alertView.showWarning("Do you really want to delete event", subTitle: "Last chance to abort")
        
        
    }
}


// MARK: -Event Join/Leave Handling
extension EventDetailsViewController{
    
    func tryToJoinEvent(){
        let date = NSDate()
        
//        let eventDate = FormatDate.getDateFromWebDBString(date: event.dateTime)
//        let earlierDate = eventDate?.earlierDate(date as Date)
//        if(earlierDate as! NSDate == date){
//            //Logika da može pustiti dalje Joinanje na Event
//        }
        
        
        webProvider.getEventsByEventId(for: self.event.id) { (result) in
            switch result{
            case .success(let event):
                if(event[0].numberOfPeople!<event[0].maxNumberOfPeople){
                    self.JoinUserToEvent()
                    
                }
                else{
                    let alert = Alerter(title: "Event is full", message: "No space for one more soul")
                    alert.alertError()
                }
            case .failure(_):
                print("failure")
            }
        }
        
        
    }
    
    func JoinUserToEvent(){
        buttonJoin.working = true
        webHandler.joinUserToEvent(for: self.event.id, userId: keychain.getID()!) { (result) in
            switch result {
            case .success(_):
                let alerter = Alerter(title: "You have successfully joined Event", message: self.event.title)
                
                alerter.alertSuccess()
                self.dismiss(animated: true) {
                    self.delegate.didHideView()
                }
            case .failure(_):
                let alerter = Alerter(title: "This User Cant Be Joined", message: "Maybe there is no space for you")
                alerter.alertError()
                self.buttonJoin.working = false
                self.labelButtonName.text = "Join"
            }
        }
        
        
    }
    
    func tryToLeaveEvent(){
        buttonJoin.working = true
        webHandler.removeUserFromEvent(for: self.event.id, userId: keychain.getID()!) { (result) in
            switch result {
                case .success(_):
                     let alerter = Alerter(title: "You have successfully removed Event", message: self.event.title)
                     
                     alerter.alertSuccess()
                     self.dismiss(animated: true) {
                         self.delegate.didHideView()
                     }
                case .failure(_):
                     let alerter = Alerter(title: "Can't remove", message: "Problem")
                     alerter.alertError()
                     self.buttonJoin.working = false
                     self.labelButtonName.text = "Remove"
                 }
            }
        
    }
}
