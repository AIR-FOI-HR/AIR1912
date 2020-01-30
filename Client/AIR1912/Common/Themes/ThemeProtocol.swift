//
//  ThemeProtocol.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

protocol ThemeProtocol {
    var backgroundColor : UIColor { get }
    var headingColor: UIColor { get }
    var textColor: UIColor { get }
    
}

struct RedTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor(named: "BaseRed")!
    var headingColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.white
}

struct DarkTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor(named: "DarkGray")!
    var headingColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.lightGray
}

struct PinkTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor(named: "BasePink")!
    var headingColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.white
}
