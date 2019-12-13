//
//  EventProvider.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//


import Foundation
import Alamofire

enum EventType: Int {
    case privateEvent = 1
    case publicEvent = 0
}

protocol Event {
    
    var id: Int { get }
    var title: String { get }
    var maxNumberOfPeople: Int { get }
    var numberOfPeople: Int { get }
    var password: String? {get}
    var description: String { get }
    var latitude: Double {get}
    var longitude: Double {get}
    var phoneNumber: String? {get}
    var isPrivate: Int {get}
    var contentID:Int {get}
    var customImage: String? {get}
    
    
}

protocol EventProvider {
    

     func getAllEvents(completion: @escaping (Result<[Event]>) -> Void)
     
     
    
}
