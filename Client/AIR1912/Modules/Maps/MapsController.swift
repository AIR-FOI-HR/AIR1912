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
        for Event in events{
            setPinOnMap(event: Event)
        }
    }
    
    func setPinOnMap(event: Event) -> Void
    {
        let pinColor = UIColor.white
        let pin = MapPin(event: event, pinColor:pinColor)
        
        
        mapView.addAnnotation(pin)
        
        let view = MKPinAnnotationView(annotation: pin, reuseIdentifier: nil)
        view.backgroundColor = UIColor.white
        view.pinTintColor = UIColor.red
   }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation")

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }

        if annotation is MapPin {
            //annotationView?.backgroundColor  = UIColor.white
        }

        return annotationView
    }
    
    

    
    // on click
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
        
        
        let storyboard = UIStoryboard(name: "MapDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "MapDetails") as? MapDetailsController else {
            return
        }
      
        viewController.modalPresentationStyle = .formSheet
        viewController.test = "woooowooo"
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
    func setRegion(latitude: Double, longitude: Double) -> Void{
        let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinateRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
