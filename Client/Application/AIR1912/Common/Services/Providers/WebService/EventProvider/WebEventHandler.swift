//
//  WebEventHandler.swift
//  AIR1912
//
//  Created by Leo Leljak on 01/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire


class WebEventHandler{

    func insertNewEvent(for event:Event, completion: @escaping (Result<[Event]>) -> Void){
        
        let decoder = JSONDecoder()
        var eventDictionary = try! event.asDictionary()
        eventDictionary["requestType"] = "insert"
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventHandler.php", method: .get, parameters: eventDictionary)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Event]>) in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }
    
    func updateEvent(for event:Event, completion: @escaping (Result<[Event]>) -> Void){
        
        let decoder = JSONDecoder()
        var eventDictionary = try! event.asDictionary()
        eventDictionary["requestType"] = "update"
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventHandler.php", method: .get, parameters: eventDictionary)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<[Event]>) in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }
    
    func deleteEvent(for eventId:Int, completion: @escaping (Result<String>) -> Void){
        
        let decoder = JSONDecoder()
        var eventDictionary:[String:Any] =  [:]
        eventDictionary["requestType"] = "delete"
        eventDictionary["deletionId"] = eventId
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventHandler.php", method: .get, parameters: eventDictionary)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<String>) in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }
    
    func joinUserToEvent(for eventId:Int, userId:Int, completion: @escaping (Result<String>) -> Void){
        
        let decoder = JSONDecoder()
        var eventDictionary:[String:Any] =  [:]
        eventDictionary["requestType"] = "joinUserToEvent"
        eventDictionary["userId"] = userId
        eventDictionary["eventJoinId"] = eventId
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventHandler.php", method: .get, parameters: eventDictionary)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<String>) in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }
    
    func removeUserFromEvent(for eventId:Int, userId:Int, completion: @escaping (Result<String>) -> Void){
        
        let decoder = JSONDecoder()
        var eventDictionary:[String:Any] =  [:]
        eventDictionary["requestType"] = "deleteUserFromEvent"
        eventDictionary["userId"] = userId
        eventDictionary["eventJoinId"] = eventId
        
        Alamofire
            .request("https://cortex.foi.hr/meetup/EventHandler.php", method: .get, parameters: eventDictionary)
            .validate()
            .responseDecodableObject(decoder: decoder) { (response: DataResponse<String>) in
                switch response.result {
                case .success(let event):
                    completion(.success(event))
                case .failure(let error):
                    completion(.failure(ResponseErrorBuilder.decodedError(fromData: response.data, fallbackError: error)))
                    print(error)
                    
            }
        }
        
    }

    
}


