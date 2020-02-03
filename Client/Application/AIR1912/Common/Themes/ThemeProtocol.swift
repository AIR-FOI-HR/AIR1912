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
    var backgroundColor: UIColor = UIColor.white
    var headingColor: UIColor = UIColor(named: "BaseRed")!
    var textColor: UIColor = UIColor.darkGray
}

struct DarkTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor.white
    var headingColor: UIColor = UIColor.black
    var textColor: UIColor = UIColor.darkGray
}

struct PinkTheme: ThemeProtocol {
    var backgroundColor: UIColor = UIColor.white
    var headingColor: UIColor = UIColor(named: "BasePink")!
    var textColor: UIColor = UIColor.darkGray
}
