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
    
    private var locationManager: CLLocationManager!
    private let keychain: UserKeychain = UserKeychain()
    
    @IBOutlet weak var blur: UIView!
    @IBOutlet weak var loadingAnimation: UIActivityIndicatorView!
    
    @IBOutlet weak var radiusSlider: UISlider!
    
    var previousValue: Int?
    
    @IBAction func radiusSliderChange(_ sender: Any) {
        if(Int(radiusSlider.value) != previousValue)
        {
            setRegion(radiusValue: Double(radiusSlider!.value * 1200))
        }
        
    }
    
    
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
        blur.isHidden = true
        previousValue = Int(radiusSlider.value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getEvents(type :movieGameSelector.selectedSegmentIndex == 0 ? "movie" : "game")
        setRegion(radiusValue: 20000)
    }
    
    
    func startLoadingAnimation(){
        blur.isHidden = false
        blur.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        loadingAnimation.startAnimating()
    }
    
    func stopLoadingAnimation(){
        blur.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        blur.isHidden = true
        loadingAnimation.stopAnimating()
    }
    
    func getEvents(type: String){
        self.startLoadingAnimation()
        
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
        
        stopLoadingAnimation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let _annotation = annotation as? MapPin {
            annotationView?.markerTintColor = _annotation.pinColor
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
    
    
    func setRegion(radiusValue: Double) -> Void{
        getUserLocation()

        let coordinateRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: radiusValue, longitudinalMeters: radiusValue)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}


extension MapsController: CLLocationManagerDelegate{
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
}
