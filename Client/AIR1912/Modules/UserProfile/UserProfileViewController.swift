//
//  UserProfileController.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView

class UserProfileViewController: UIViewController, EventDetailsDelegate {
    func didHideView() {
        self.viewWillAppear(true)
    }
    

    //MARK: - Outlets
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var nicknameText: UILabel!
    @IBOutlet weak var MyEventsCollectionView: UICollectionView!
    @IBOutlet weak var AttendingEventsCollectionView: UICollectionView!
    @IBOutlet weak var myEventsLabel: UILabel!
    @IBOutlet weak var atendingEventsLabel: UILabel!
    @IBOutlet weak var settingButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var behindView: UIView!
    
    //MARK: - Private properties

    private var myEventsDataSource = [Event]()
    private var attendingEventsDataSource = [Event]()
    private let keychain:UserKeychain = UserKeychain()
    
    //MARK: - Lifecycle
    private func updateUser(){
        // set avatar from keychain
            let avatarValue = self.keychain.getAvatar()
        let avatar = Avatar(rawValue: avatarValue!)
        let userImage = avatar!.image

            self.userAvatar.image = userImage
        
        // set welcome message with nickname
            let userNickname = self.keychain.getNickname()
            self.nicknameText.text = "Hi " + userNickname!
        AttendingEventsCollectionView.delegate = self
        MyEventsCollectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUser()
    
}
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            updateUser()
            getEventsByUserID(for: .allEvent)
            getEventsByOwnerID(for: .allEvent)
            
            nicknameText.textColor = Theme.current.headingColor
            myEventsLabel.textColor = Theme.current.headingColor
            atendingEventsLabel.textColor = Theme.current.headingColor
            settingButton.tintColor = Theme.current.headingColor
            
            self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
            let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
            navigationController?.navigationBar.titleTextAttributes = textAttributes

           
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
            self.MyEventsCollectionView.showAnimatedGradientSkeleton()
            self.AttendingEventsCollectionView.showAnimatedGradientSkeleton()
            let provider = WebEventProvider()
            provider.getEventsByOwnerId (for: idUser, eventType: EventType.allEvent){ (result) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.MyEventsCollectionView.hideSkeleton()
                    self.AttendingEventsCollectionView.hideSkeleton()
                }
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
               self.MyEventsCollectionView.showAnimatedGradientSkeleton()
               self.AttendingEventsCollectionView.showAnimatedGradientSkeleton()
               let provider = WebEventProvider()
        provider.getEventsByUserID (for: idUser, eventType: EventType.allEvent){ (result) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.MyEventsCollectionView.hideSkeleton()
                self.AttendingEventsCollectionView.hideSkeleton()
            }
            switch result {
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

extension UserProfileViewController: SkeletonCollectionViewDataSource, UICollectionViewDataSource {
       
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "UserProfileCollectionViewCell"
    }
    
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
       
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                    print("KLIK")
                   let storyboard = UIStoryboard(name: "EventDetails", bundle: nil)
                   guard let viewController = storyboard.instantiateViewController(identifier: "EventDetails") as? EventDetailsViewController else {
                       return
                   }
                   let datasource: [Event]
            if collectionView === self.MyEventsCollectionView {
                       datasource = myEventsDataSource
            } else if collectionView == self.AttendingEventsCollectionView {
                       datasource = attendingEventsDataSource
                   } else {
                       return
                   }
                   let event = datasource[indexPath.row]
                   viewController.event = event
                   viewController.modalPresentationStyle = .popover
                    viewController.delegate = self
                   self.present(viewController, animated: true, completion: nil)
               }
        
    
    
   }
    
    
    
    

