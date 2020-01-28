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
    
    
    
    //properties
    var event:Event = Event()
    let cornerRadius : CGFloat = 12
    let keychain = UserKeychain()
    
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
        floatyButton.addItem(item: update)
        let trash = FloatyItem()
        trash.icon = UIImage(named: "trash")
        trash.buttonColor = UIColor(hex:  "FF1306")
        floatyButton.addItem(item: trash)
        
        
        
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
        let comp = calendar.dateComponents([.day, .hour, .minute, .year], from: dateFromString as! Date)
        
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
    
    func confIfPrivate(){
        buttonJoin.backgroundColorForStateNormal = UIColor(hex: "FF1306")
        shadowView.backgroundColor = UIColor(hex: "FF1306").withAlphaComponent(0.55)
        
    }
  
    func geocode(latitude: Double , longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
               CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
           }
}
