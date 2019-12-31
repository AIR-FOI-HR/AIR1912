//
//  UserProfileController.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit
import Kingfisher

class UserProfileViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var nicknameText: UILabel!
    @IBOutlet weak var MyEventsCollectionView: UICollectionView!
    @IBOutlet weak var AttendingEventsCollectionView: UICollectionView!
    
    //MARK: - Private properties

    private var myEventsDataSource = [Event]()
    private var attendingEventsDataSource = [Event]()
    private let keychain:UserKeychain = UserKeychain()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set avatar from keychain
        
            let avatarValue = self.keychain.getAvatar()
        let avatar = Avatar(rawValue: avatarValue!)
        let userImage = avatar!.image

            self.userAvatar.image = userImage
        
        // set welcome message with nickname
            let userNickname = self.keychain.getNickname()
            self.nicknameText.text = "Hi " + userNickname!
    
}
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            getEventsByUserID(for: .allEvent)
            getEventsByOwnerID(for: .allEvent)
    }
    
        @IBAction func testEventDetails(_ sender: Any) {
        
        let EventDetailsStoryboard:UIStoryboard = UIStoryboard(name: "EventCRUD", bundle: nil)
        let EventDetailsViewController = EventDetailsStoryboard.instantiateViewController(identifier: "EventCRUD") as! EventCRUDViewController
        EventDetailsViewController.modalPresentationStyle = .popover
        self.present(EventDetailsViewController, animated: true, completion: nil)
        
        }
               
        private func getEventsByOwnerID(for type: EventType) {
            
            guard let idUser = keychain.getID() else{
                return
            }
            
            let provider = WebEventProvider()
            provider.getEventsByOwnerId (for: idUser, eventType: EventType.allEvent){ (result) in
                switch result {
                case .success(let podaci):
                    print (podaci)
                    self.updateMyEventsContent(result: podaci)
                    
                case .failure(_):
                    print("failure")
                    self.updateMyEventsContent(result: [])
                }
            }

    }
    
    private func getEventsByUserID(for type: EventType) {
               
               guard let idUser = keychain.getID() else{
                   return
               }
               
               let provider = WebEventProvider()
        provider.getEventsByUserID (for: idUser, eventType: EventType.allEvent){ (result) in  switch result {
                   case .success(let podaci):
                       print (podaci)
                       self.updateAttendingEventsContent(result: podaci)
                       
                   case .failure(_):
                       print("failure")
                       self.updateAttendingEventsContent(result: [])
                   }
               }

       }
        private func updateMyEventsContent(result: [Event]) {
            
                myEventsDataSource = result
                self.MyEventsCollectionView.reloadData()
    
        }
    
    private func updateAttendingEventsContent(result: [Event]) {
            
                attendingEventsDataSource = result
                self.AttendingEventsCollectionView.reloadData()
    
        }
}

extension UserProfileViewController: UICollectionViewDataSource {
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
        if collectionView === self.MyEventsCollectionView {
               return myEventsDataSource.count
           } else {
            return attendingEventsDataSource.count
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCollectionViewCell", for: indexPath) as! UserProfileCollectionViewCell
           let event: Event
        if collectionView === self.MyEventsCollectionView {
               event = myEventsDataSource[indexPath.row]
               cell.configureForMyEvents(with: event)
               
           } else {
            event = attendingEventsDataSource[indexPath.row]
            cell.configureForMyEvents(with: event)
        }
           
           return cell
       }
   }
    
    
    
    

