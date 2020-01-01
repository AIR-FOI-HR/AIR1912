//
//  Event.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation



struct Event: Decodable, Encodable {
    
       var id: Int
       var title: String
       var maxNumberOfPeople: Int
       var numberOfPeople: Int?
       var password: String?
       var description: String
       var latitude: Double
       var longitude: Double
       var phoneNumber: String?
       var isPrivate: Int
       var contentID:Int
       var customImage: String?
       var dateTime: String
       var ownerId: Int
       
    
    
     init(title: String, maxNumberOfPeople: Int, numberOfPeople: Int?, password: String?, description: String, latitude: Double, longitude: Double, phoneNumber: String?, isPrivate: Int, contentID: Int, customImage: String?, dateTime: String, ownerId: Int) {
       
        self.id = 0
        self.title = title
        self.maxNumberOfPeople = maxNumberOfPeople
        self.numberOfPeople = numberOfPeople
        self.password = password
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.phoneNumber = phoneNumber
        self.isPrivate = isPrivate
        self.contentID = contentID
        self.customImage = customImage
        self.dateTime = dateTime
        self.ownerId = ownerId
    }
    
    init(title: String, maxNumberOfPeople: Int, description: String, latitude: Double, longitude: Double, isPrivate: Int, contentID: Int, dateTime: String, ownerId: Int) {
       
        self.id = 0
        self.title = title
        self.maxNumberOfPeople = maxNumberOfPeople
        self.numberOfPeople = 0
        self.password = nil
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.phoneNumber = nil
        self.isPrivate = isPrivate
        self.contentID = contentID
        self.customImage = nil
        self.dateTime = dateTime
        self.ownerId = ownerId
    }
   
    
    
    
}
