//
//  MapsVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 27/11/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import UIKit
import MapKit

class MapsController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        getAllEvents()
        
    }
    
    func getAllEvents(){
        let provider = WebEventProvider()
        provider.getAllEvents(){ (result) in
            
            switch result {
            case .success(let events):
                self.populateMapWithPins(events: events)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func populateMapWithPins(events:[Event]){
        // provjeri je li event privatan ili javan i ovisno o tome postavi boju
        for event in events{
            if(event.isPrivate == 1){
                let pin = MapPin(event: event, pinColor: UIColor.red)
                mapView.addAnnotation(pin)
            }
            else{
                let pin = MapPin(event: event, pinColor:UIColor.green)
                mapView.addAnnotation(pin)
            }
            
        }
    }
    
    // pokusaj bojanja pinova - ne funkcionira
    private func mapView(_ mapView: MKMapView, viewFor annotation: MapPin) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.tintColor = UIColor(red: 0, green: 100, blue: 0, alpha: 0.5)
        annotationView?.backgroundColor = UIColor.white
        
        return annotationView
    }

    
    // on click
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
        
        let selectedEvent = view.annotation as? MapPin
        
        let storyboard = UIStoryboard(name: "MapDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "MapDetails") as? MapDetailsController else {
            return
        }
      
        viewController.modalPresentationStyle = .formSheet
        viewController.selectedEvent = selectedEvent?.event
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func setRegion(latitude: Double, longitude: Double) -> Void{
        let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinateRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
