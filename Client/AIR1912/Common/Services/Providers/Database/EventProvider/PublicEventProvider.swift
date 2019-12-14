//
//  GameEventProvider.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation
import Alamofire


class PublicEventProvider: EventProvider{
    private let decoder = JSONDecoder()
    
    
    
    func getAllEventsByUserID(for id: Int, completion: @escaping (Result<[Event]>) -> Void) {
        Alamofire
        .request("https://cortex.foi.hr/meetup/PublicEventProvider.php?searchByID=\(id)")
        .responseDecodableObject(decoder: decoder) { (response: DataResponse<[PublicEvent]>) in
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
               .request("https://cortex.foi.hr/meetup/PublicEventProvider.php")
               .responseDecodableObject(decoder: decoder) { (response: DataResponse<[PublicEvent]>) in
                   switch response.result {
                   case .success(let response):
                    
                    completion(.success(response))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
    }
    
    
    
   
    
    
    
}
