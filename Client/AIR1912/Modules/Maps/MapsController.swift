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
        setPinOnMap(latitude:  46.306868, longitude: 16.333505, title: "Naslov", subtitle: "Subtitle")
        setPinOnMap(latitude:  46.31, longitude: 16.4, title: "Naslov 2", subtitle: "Subtitle")
        
       
    }
    
    
    func setPinOnMap(latitude: Double, longitude: Double, title: String, subtitle: String) -> Void
    {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let pin = MapPin(title: title, subtitle: subtitle, coordinate: location)
        mapView.addAnnotation(pin)
        
   }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
    }
    
    
    
    func setRegion(latitude: Double, longitude: Double) -> Void{
        let userLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinateRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
