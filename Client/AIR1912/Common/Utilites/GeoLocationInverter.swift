//
//  GetLocationFromCoordinates.swift
//  AIR1912
//
//  Created by Leo Leljak on 29/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import CoreLocation

class GeoLocationInverter{
    
    static func geocode(latitude: Double , longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
               CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
           }

}
