//
//  ContentDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 18/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import LocationPickerViewController

class EventCRUDViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    

    //MARK: - Outlets
    
   
    @IBOutlet weak var pickerNumber: UIPickerView!
    @IBOutlet weak var pickedLocationAdressLabel: UILabel!
    @IBOutlet weak var pickedLocationNameTextField: UITextView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    //MARK: - Properties
    
    var id: Int = 512200
    var type: ContentType = .movie
    let cornerRadius : CGFloat = 12
    var genreName = ""
    var pickerData: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    

    //MARK: - Lifecycle

    override func viewDidLoad() {
    super.viewDidLoad()
    setShadowView()
    configure(for: type)
    self.pickerNumber.delegate = self
    self.pickerNumber.dataSource = self

     }
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
    
    func setUpView(for Content: Content) {
        self.frontImage.kf.setImage(with: Content.posterURL)
        self.setBlurredImage(poster: Content.posterURL)
        
    }
    
   
    
    func configure(for type: ContentType) {
        let provider = ContentProviderFactory.contentProvider(forContentType: type)
               switch type {
               case .movie:
                  
                   provider.getDetails(id: id) { (result) in
                                   switch result {
                                   case .success(let podaci):
                                      
                                       self.setUpView(for: podaci)
                                   case .failure(_):
                                       break
                                   }
                               }
               case .game:
                   
                   provider.getDetails(id: id) { (result) in
                       switch result {
                       case .success(let podaci):
                           
                           self.setUpView(for: podaci)
                       case .failure(_):
                           break
                       }
                       
                   }
                   
               }
                
    }
    
    @IBAction func openPickLocation(_ sender: Any) {
        
        let locationPicker = LocationPicker()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            self.pickedLocationNameTextField.text = pickedLocationItem.name
        }
        locationPicker.addBarButtons()
        
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func openDateTimePicker(_ sender: Any) {
        let DateTimePickerStoryboard:UIStoryboard = UIStoryboard(name: "DateTimePicker", bundle: nil)
        let DateTimeVC = DateTimePickerStoryboard.instantiateViewController(identifier: "DateTimePicker") as? DateTimePickerViewController
        DateTimeVC?.delegate = self
        self.present(DateTimeVC!, animated: true, completion: nil)
    }
    
    
}
extension EventCRUDViewController: DateTimePickerDelegate{
    func setDateTime(dateTime: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let stringDate = dateFormatter.string(from: dateTime)
        dateTimeLabel.text = stringDate
    }
    
    
}
