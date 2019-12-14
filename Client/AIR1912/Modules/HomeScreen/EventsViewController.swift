//
//  EventsViewController.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation

class EventsViewController: UIViewController {
    // MARK: - Private outlets
        
        @IBOutlet private weak var collectionView: UICollectionView!
        @IBOutlet private weak var collectionView2: UICollectionView!
        
       
        // MARK: - Private properties
        
        private var gamesDatasource = [Event]()
        private var movieDatasource = [Event]()
        private let keychain:UserKeychain = UserKeychain()
        private var locationManager: CLLocationManager!
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            getUserLocation()
 
            getAllEventsByUserID(for: .publicEvent)
            getAllEventsByLocation(for: .privateEvent)
            
        }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserLocation()
        
                   getAllEventsByUserID(for: .publicEvent)
                   getAllEventsByLocation(for: .privateEvent)
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
        
        private func getAllEventsByLocation(for type: EventType){
            let provider = PrivateEventProvider()
            provider.getAllEvents{ (result) in
                           switch result {
                           case .success(let podaci):
                               print ("ovo su podaci \(podaci)")
                               self.updateContent(for: type, result: podaci)
                               
                           case .failure(_):
                               print("failure je ovdje")
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
                
                //Izbaciti iz popisa sve one koji nisu Near korisnika
                removeNearEvents(for: movieDatasource)
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
            if collectionView === self.collectionView {
                event = movieDatasource[indexPath.row]
                cell.configureForNearEvents(with: event)
                
                
            } else {
                event = gamesDatasource[indexPath.row]
                cell.configureForMyEvents(with: event)
            }
            
            return cell
        }
    }

extension EventsViewController: CLLocationManagerDelegate{
    func getUserLocation() {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {

        let location = locations.last! as CLLocation
        keychain.saveLocationData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print(keychain.getLatestLocation().coordinate)
    }
    
    func isNearUser(event:Event) -> Bool {
        let userLocationCordinates = keychain.getLatestLocation()
        let eventLocationCordinates = CLLocation(latitude: event.latitude, longitude: event.longitude)
        
        let distanceInMeters = userLocationCordinates.distance(from: eventLocationCordinates)
        guard distanceInMeters>10000 else {return true}
        return false
    }
    
    func removeNearEvents(for source:[Event]){
        for event in movieDatasource{
            if(!isNearUser(event: event)){
                movieDatasource.removeAll(where: { $0.id == event.id })
            }
            
        }
    }
    
}
