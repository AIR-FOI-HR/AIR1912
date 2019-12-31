//
//  DBContentProvider.swift
//  AIR1912
//
//  Created by Leo Leljak on 14/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

protocol DBContentProvider {
    
    func getContentByID(for id:Int, completion: @escaping (Result<[DBMovie]>) -> Void)
    
    
}
