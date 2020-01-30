//
//  HomeScreenTBC.swift
//  AIR1912
//
//  Created by Leo Leljak on 27/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class HomeSreenTabBarController: UITabBarController {

    //MARK: - IBOutlets

    //MARK: - Properties
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTabBar()
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
        self.navigationController?.navigationBar.tintColor = Theme.current.headingColor
        let textAttributes = [NSAttributedString.Key.foregroundColor:Theme.current.headingColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
    
    }
    
   
    
}

extension HomeSreenTabBarController {
    
    func setupTabBar(){
        self.selectedIndex = 2
        
    }
    
}
