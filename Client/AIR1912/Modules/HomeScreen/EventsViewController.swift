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
import SkeletonView

class EventsViewController: UIViewController {
    // MARK: - Private outlets
        
        @IBOutlet private weak var nearEventsCollectionView: UICollectionView!
        @IBOutlet private weak var myEventsCollectionView: UICollectionView!
        
        @IBOutlet weak var eventsNearMeLabel: UILabel!
    
        // MARK: - Private properties
        
        private var myEventsDataSource = [Event]()
        private var nearEventsDataSource = [Event]()
        private let keychain:UserKeychain = UserKeychain()
        private var locationManager: CLLocationManager!
        // MARK: - Lifecycle
    @IBOutlet weak var skeleton: UICollectionView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            getUserLocation()
            eventsNearMeLabel.textColor = ThemesManager.shared.theme?.baseColor
            
            view.isSkeletonable = false
           
            //view.showAnimatedGradientSkeleton()
            getAllEventsByUserID(for: .allEvent )
            getAllEventsByLocation(for: .allEvent)
           
            //self.view.hideSkeleton()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
           getUserLocation()
            getAllEventsByUserID(for: .allEvent )
            getAllEventsByLocation(for: .allEvent)

        }
    
    
        
    }


    extension EventsViewController {
        
        
        private func getAllEventsByUserID(for type: EventType) {
            view.showAnimatedGradientSkeleton()
            guard let idUser = keychain.getID() else{
                return
            }
            
            let provider = WebEventProvider()
            provider.getEventsByUserID(for: idUser, eventType: type){ (result) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  self.view.hideSkeleton()
                }
                
                
                switch result {
                    
                case .success(let podaci):
                    
                    print (podaci)
                    self.updateMyEventsContent(result: podaci)
                    
                    
                    
                case .failure(let error):
                    print(error)
                    self.updateMyEventsContent(result: [])
                }
                
            }
            
            
        }
        
        private func getAllEventsByLocation(for type: EventType){
           let provider = WebEventProvider()
            provider.getAllEvents{ (result) in
                           switch result {
                           case .success(let podaci):
                                
                               print ("ovo su podaci \(podaci)")
                               self.updateNearEventsContent( result: podaci)
                           
                            

                           case .failure(_):
                               print("failure je ovdje")
                               self.updateNearEventsContent( result: [])
                           }
                
                       }
             
        }
        
        private func updateMyEventsContent(result: [Event]) {
            
                myEventsDataSource = result
                self.myEventsCollectionView.reloadData()
                //self.view.hideSkeleton()
           
    
        }
        
        private func updateNearEventsContent(result: [Event]) {
                   
                       nearEventsDataSource = result
                       
                       //Izbaciti iz popisa sve one koji nisu Near korisnika
                       removeNotNearEvents(for: nearEventsDataSource)
                       self.nearEventsCollectionView.reloadData()
                      // self.view.hideSkeleton()
                     
               }
    }

extension EventsViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "EventCollectionViewCell"
    }
    
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView === self.nearEventsCollectionView {
                return nearEventsDataSource.count
            } else {
                return myEventsDataSource.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            let event: Event
            if collectionView === self.nearEventsCollectionView {
                event = nearEventsDataSource[indexPath.row]
                cell.configureForNearEvents(with: event)
                
                
            } else {
                event = myEventsDataSource[indexPath.row]
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
        _ = keychain.saveLocationData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print(keychain.getLatestLocation().coordinate)
    }
    
    func isNearUser(event:Event) -> Bool {
        if(locationGranted()){
            let userLocationCordinates = keychain.getLatestLocation()
            let eventLocationCordinates = CLLocation(latitude: event.latitude, longitude: event.longitude)
            
            let distanceInMeters = userLocationCordinates.distance(from: eventLocationCordinates)
            guard distanceInMeters>10000 else {return true}
        }
        
        return false
    }
    
    func removeNotNearEvents(for source:[Event]){
        for event in nearEventsDataSource{
            if(!isNearUser(event: event)){
                nearEventsDataSource.removeAll(where: { $0.id == event.id })
            }
            
        }
    }
    
    func locationGranted()-> Bool{
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    return false
                case .authorizedAlways, .authorizedWhenInUse:
                    return true
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
        return false
    }
    
}
