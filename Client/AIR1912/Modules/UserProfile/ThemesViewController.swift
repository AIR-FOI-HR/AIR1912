//
//  ThemesViewController.swift
//  AIR1912
//
//  Created by Infinum on 29/01/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    @IBOutlet weak var lightThemeLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    @IBOutlet weak var pinkThemeLabel: UILabel!
    @IBOutlet weak var lightThemeSwitch: UISwitch!
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    @IBOutlet weak var pinkThemeSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        

    }
    
    private func applyTheme(){
        lightThemeLabel.textColor = Theme.current.baseColor
    }
    
    @IBAction func redThemeButton(_ sender: Any) {
        Theme.current = RedTheme()
        
        UserDefaults.standard.set((sender as AnyObject).tag, forKey: "Theme")
        
        applyTheme()
    }
    @IBAction func darkThemeButton(_ sender: Any) {
        Theme.current = DarkTheme()
        
        UserDefaults.standard.set((sender as AnyObject).tag, forKey: "Theme")
        
        applyTheme()
    }
    @IBAction func pinkThemeButton(_ sender: Any) {
        Theme.current = PinkTheme()
        
        UserDefaults.standard.set((sender as AnyObject).tag, forKey: "Theme")
        
        applyTheme()
    }
    
    
}
