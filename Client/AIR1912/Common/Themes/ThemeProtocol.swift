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
    var baseColor : UIColor { get }
}

struct RedTheme: ThemeProtocol {
    var baseColor: UIColor = UIColor(named: "BaseRed")!
}

struct DarkTheme: ThemeProtocol {
    var baseColor: UIColor = UIColor.black
}

struct PinkTheme: ThemeProtocol {
    var baseColor: UIColor = UIColor(named: "BasePink")!
}
