//
//  EventsViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher


class EventsViewController: UIViewController {
    // MARK: - Private outlets
        
        @IBOutlet private weak var collectionView: UICollectionView!
        @IBOutlet private weak var collectionView2: UICollectionView!
        
       
        // MARK: - Private properties
        
        private var gamesDatasource = [Event]()
        private var movieDatasource = [Event]()
        private let keychain:UserKeychain = UserKeychain()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //getUserLocation(for: keychain.getID())
            
            
            getAllEventsByUserID(for: .publicEvent)
            
        }
        
        
        
        
    }

    extension EventsViewController {
        
        private func getAllEventsByUserID(for type: EventType) {
            
            guard let idUser = keychain.getID() else{
                return
            }
            
            let provider = EventProviderFactory.eventProvider(forEventType: type)
            provider.getAllEventsByUserID(for: idUser){ (result) in
                switch result {
                case .success(let podaci):
                    print (podaci)
                    self.updateContent(for: type, result: podaci)
                    
                case .failure(_):
                    print("failure")
                    self.updateContent(for: type, result: [])
                }
            }
        }
        
        private func updateContent(for type: EventType, result: [Event]) {
            switch type {
            case .publicEvent:
                gamesDatasource = result
                self.collectionView2.reloadData()
            case .privateEvent:
                movieDatasource = result
                print(movieDatasource)
                self.collectionView.reloadData()
            }
        }
    }

    extension EventsViewController: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView === self.collectionView {
                return movieDatasource.count
            } else {
                return gamesDatasource.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            let event: Event
            if collectionView === self.collectionView{
                event = movieDatasource[indexPath.row]
            } else {
                event = gamesDatasource[indexPath.row]
            }
            cell.configure(with: event)
            return cell
        }
    }

extension EventsViewController{
    
    
}
