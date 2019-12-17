//
//  DBConcent.swift
//  AIR1912
//
//  Created by Infinum on 15/12/2019.
//  Copyright © 2019 Infinum. All rights reserved.
//

import Foundation

struct DBContent: Codable{
    let id:Int?
    let sourceEntityId:Int
    let type:String
    let title:String
    let overview:String
    let poster_path:String
    let release_date: String
    let runtime:Int
    let posterURL:String
}
