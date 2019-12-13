//
//  EventProviderFactory.swift
//  AIR1912
//
//  Created by Leo Leljak on 13/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

class EventProviderFactory {
    static func eventProvider(forEventType eventType: EventType) -> EventProvider {
      switch eventType {
      case .publicEvent:
          return PublicEventProvider()
      case .privateEvent:
         return PrivateEventProvider()
      
        
      }
   }
}
