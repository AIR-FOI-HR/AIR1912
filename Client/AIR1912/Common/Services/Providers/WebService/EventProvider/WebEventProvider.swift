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
    case publicEvent = 0
    case privateEvent = 1
    case allEvent = 2
}

enum PostType:String {
    case allEvents = "allEvents"
    case searchByUserId = "searchByUserId"
    case createdByUserId = "createdByUserId"
}

class WebEventProvider {
    private let decoder = JSONDecoder()
    
    
    
    func getEventsByUserID(for id: Int, eventType: EventType, completion: @escaping (Result<[Event]>) -> Void) {
        
        let parameters = [
            "postType": PostType.searchByUserId.rawValue,
            "eventType": eventType.rawValue,
            "firstParam": id
            ] as [String : Any]
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventProvider.php", method: .get, parameters: parameters)
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Event]>) in
            switch response.result {
            case .success(let response):
             
             completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
     
    
    func getAllEvents( completion: @escaping (Result<[Event]>) -> Void) {
         Alamofire
               .request("https://cortex.foi.hr/meetup/EventProvider.php")
               .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Event]>) in
                   switch response.result {
                   case .success(let response):
                    
                    completion(.success(response))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
    }
    
    func getEventsByOwnerId(for id: Int, eventType: EventType, completion: @escaping (Result<[Event]>) -> Void){
        let parameters = [
                   "postType": PostType.createdByUserId.rawValue,
                   "eventType": eventType.rawValue,
                   "firstParam": id
                   ] as [String : Any]
               
               Alamofire
                   .request("https://cortex.foi.hr/meetup/EventProvider.php", method: .get, parameters: parameters)
               .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Event]>) in
                   switch response.result {
                   case .success(let response):
                    completion(.success(response))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
        
    }
    
    
    
   
    
    
    
}

