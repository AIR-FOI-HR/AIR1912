//
//  ContentDetailsController.swift
//  AIR1912
//
//  Created by Infinum on 18/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import LocationPickerViewController

class EventCRUDViewController: UIViewController {
    
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
    var pickedDate:Date = Date()
    var contentInDatabase:DBContent?
    

    //MARK: - Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setShadowView()
        configure(for: type)
        setPickerView()
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
        DateTimeVC?.modalPresentationStyle = .overCurrentContext
        DateTimeVC?.delegate = self
        self.present(DateTimeVC!, animated: true, completion: nil)
    }
    
    @IBAction func createEventButtonSelected(_ sender: Any) {
        
        checkIfContentExistInWebDatabase(for: self.id, contentType: self.type)
        
        //TODO:
        //Insert Event into Database with content ID from contentInDatabase.id
        
            
            
            
            
            
        }
        
        
}
    


extension EventCRUDViewController{
    
    func setPickerView(){
         
         self.pickerNumber.delegate = self
         self.pickerNumber.dataSource = self
         self.pickerNumber.selectRow(4, inComponent: 0, animated: true)
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
}


extension EventCRUDViewController: DateTimePickerDelegate{
    func setDateTime(dateTime: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let stringDate = dateFormatter.string(from: dateTime)
        dateTimeLabel.text = stringDate
    }
    
    
}

extension EventCRUDViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
}


extension EventCRUDViewController{
    
    func checkIfContentExistInWebDatabase(for sourceContentId:Int, contentType:ContentType) {
    
        let provider = WebContentProvider()
        provider.checkIfContentExist(for: sourceContentId, contentType: contentType){(result) in
            
            switch result{
                case .success(let content):
                    //Ako Content postoji u bazi
                    self.contentInDatabase = content[0]
                    
            case .failure(_):
                //Ako ne postoji u bazi taj Content
                self.getContentFromAPI(for: self.type, id: self.id)
                break
            }
            
            }
            
        
    }
    
    func getContentFromAPI(for type:ContentType, id:Int){
        let contentProvider = ContentProviderFactory.contentProvider(forContentType: type)
        
        var contentDB:DBContent?
        contentProvider.getDetails(id: id){(result) in
            
            switch result{
                case .success(let content):
                    contentDB = DBContent(content: content, type: self.type)
                    self.insertContentIntoDatabase(for: contentDB!)
                    
                    
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func insertContentIntoDatabase(for content:DBContent){
        let contentHandler = WebContentHandler()
        
        contentHandler.insertNewContent(for: content){(result) in
            
            switch result{
            case .success(let content):
                print("Content koji se unasa:\(content)")
                self.contentInDatabase = content
            case .failure(let errors):
                print("greska pri unosu contenta\(errors)");
            }
            
        }
        
    }
    
    
    
    
}
