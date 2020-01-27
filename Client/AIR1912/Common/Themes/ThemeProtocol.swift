//
//  ThemeProtocol.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

protocol Theme {
    var baseColor : UIColor { get }
}

struct RedTheme: Theme {
    var baseColor: UIColor = UIColor.init(named: "BaseRed")!
}

struct DarkTheme: Theme {
    var baseColor: UIColor = UIColor.black
}

struct PinkTheme: Theme {
    var baseColor: UIColor = UIColor.init(named: "BasePink")!
}
