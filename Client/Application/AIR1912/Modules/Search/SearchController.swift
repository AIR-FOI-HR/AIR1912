//
//  SearchVC.swift
//  AIR1912
//
//  Created by Leo Leljak on 27/11/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit

class SearchController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.tintColor = Theme.current.headingColor
    }

}
