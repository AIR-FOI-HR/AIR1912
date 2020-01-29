//
//  MapPin.swift
//  AIR1912
//
//  Created by Infinum on 28/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation{
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let event: Event
    let pinColor: UIColor
    
    init(event: Event, pinColor: UIColor){
        self.title = event.title
        self.subtitle = "Number of people: \(String(describing: event.numberOfPeople))"
        self.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
        self.pinColor = pinColor
        self.event = event
    }
}
