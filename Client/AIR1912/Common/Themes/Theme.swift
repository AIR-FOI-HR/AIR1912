//
//  ThemeManager.swift
//  AIR1912
//
//  Created by Infinum on 27/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    static var current: ThemeProtocol = RedTheme()
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    private(set) lazy var currentTheme = loadTheme()
//    private let defaults: UserDefaults
//    private let defaultsKey = "theme"
//
//    init(defaults: UserDefaults = .standard) {
//        self.defaults = defaults
//    }
//
//    func changeTheme(to theme: Themes) {
//        currentTheme = theme
//        defaults.setValue(theme.rawValue, forKey: defaultsKey)
//    }
//
//    private func loadTheme() -> Themes {
//        let rawValue = defaults.string(forKey: defaultsKey)
//
//        if let themeValue = UserDefaults.standard.value(forKey: defaultsKey) {
//            if case Themes.red = themeValue{
//                return rawValue.flatMap(Themes.init) ?? .red
//            }else if case Themes.dark = themeValue{
//                return rawValue.flatMap(Themes.init) ?? .dark
//            }else if case Themes.pink = themeValue{
//                return rawValue.flatMap(Themes.init) ?? .pink
//            }else{
//                return rawValue.flatMap(Themes.init) ?? .red
//            }
//        }else{
//            return rawValue.flatMap(Themes.init) ?? .red
//        }
//    }

