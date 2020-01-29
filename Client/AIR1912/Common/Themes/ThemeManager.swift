//
//  ThemeManager.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

class ThemesManager {
    
    var theme: Theme {
        didSet {
            applyTheme()
        }
    }
    
    private init() {
//        let initialTheme: String
//        if let themeValue = UserDefaults.standard.value(forKey: "theme") {
//            if themeValue == "red" {
//                initialTheme = RedTheme()
//            } else if theme == "dark" {
//                initialTheme = DarkTheme()
//            } else if ...
//            else
//            Red
//        } else {
//            initialTheme = RedTheme()
//        }
//
//        theme = initialTheme
        theme = RedTheme()
    }
    
    static var shared: ThemesManager = {
        let themeneManager  = ThemesManager()
        return themeneManager
    }()
    
    func setTheme(theme: Theme) {
        self.theme = theme
    }
    
    func applyTheme() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 63.0/255.0, green: 172.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    }
    
    func changeTheme(with identifier: String) {
        UserDefaults.standard.setValue(identifier, forKey: "theme")
    }
}
