//
//  ThemeManager.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

class ThemesManager {
   var theme : Theme?
   static var shared : ThemesManager = {
        let themeneManager  = ThemesManager()
        return themeneManager
    }()
   func setTheme(theme : Theme){
        self.theme = theme
    }
}
