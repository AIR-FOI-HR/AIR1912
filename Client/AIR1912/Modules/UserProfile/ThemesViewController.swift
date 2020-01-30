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
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        redButton.layer.cornerRadius = 15.0
        blackButton.layer.cornerRadius = 15.0
        pinkButton.layer.cornerRadius = 15.0
        applyTheme()
    }
    
    private func applyTheme(){
        view.backgroundColor = Theme.current.backgroundColor
        lightThemeLabel.textColor = Theme.current.headingColor
        UIBarButtonItem.appearance().tintColor = Theme.current.headingColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.headingColor]
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
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
