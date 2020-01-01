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
        //contentDic["requestType"] = "insertNewEvent"
        
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
    

    
}


