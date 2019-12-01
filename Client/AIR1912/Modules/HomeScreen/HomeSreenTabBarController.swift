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
    
    }
    
}

extension HomeSreenTabBarController {
    
    func setupTabBar(){
        self.selectedIndex = 2
    }
    
}