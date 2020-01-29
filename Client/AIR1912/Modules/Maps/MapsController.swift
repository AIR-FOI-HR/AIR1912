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
    @IBOutlet weak var movieGameSelector: UISegmentedControl!
    @IBAction func movieGameSelector(_ sender: Any) {
        let getIndex = movieGameSelector.selectedSegmentIndex
        
        switch (getIndex){
        case 0:
            getEvents(type: "movie")
            
        case 1:
            getEvents(type: "game")
            
        default:
            print("default")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        getEvents(type: "movie")
        
    }
    
    func getEvents(type: String){
       let annotations = self.mapView.annotations
            for annotation in annotations {
                self.mapView.removeAnnotation(annotation)
            }
        
        
        let provider = WebEventProvider()
        provider.getAllEvents(){ (result) in
            
            switch result {
            case .success(let events):
                self.populateMapWithPins(events: events, type: type)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeAllAnnotations(){
        
    }
    
    func populateMapWithPins(events:[Event], type: String){
        for event in events{
            // provjera tipa contenta
            let provider = WebContentProvider()
            provider.getContentById(for: event.contentID){ (result) in

                switch result{
                case .success(let content):
                    test(contentType: content[0].type!)
                case .failure(let error):
                    print(error)
                }
            }

            func test(contentType: String){
                
                // provjera privatnosti eventa
                if(contentType == type)
                {
                    print(contentType)
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
        
        // na view controller detaljnog prikaza pridodaj odabrani event
        viewController.selectedEvent = selectedEvent!.event
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func setRegion(latitude: Double, longitude: Double) -> Void{
        let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinateRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
