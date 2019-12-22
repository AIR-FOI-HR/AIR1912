//
//  Event.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation



class Event: Decodable, Encodable {
    
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
    
}
