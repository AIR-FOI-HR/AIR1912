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
        
        getAllEventsByUserID(for: .allEvents)

    
}
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            getAllEventsByUserID(for: .allEvents)
        
        }
        
               
        private func getAllEventsByUserID(for type: EventType) {
            
            guard let idUser = keychain.getID() else{
                return
            }
            
            let provider = EventProviderFactory.eventProvider(forEventType: type)
            provider.getAllEventsByUserID(for: idUser){ (result) in
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
        private func updateMyEventsContent(result: [Event]) {
            
                myEventsDataSource = result
                self.MyEventsCollectionView.reloadData()
    
        }
}

extension UserProfileViewController: UICollectionViewDataSource {
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
               return myEventsDataSource.count
           
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCollectionViewCell", for: indexPath) as! UserProfileCollectionViewCell
           let event: Event
        if collectionView === self.MyEventsCollectionView {
               event = myEventsDataSource[indexPath.row]
               cell.configureForMyEvents(with: event)
               
           }
           
           return cell
       }
   }
    
    
    
    

