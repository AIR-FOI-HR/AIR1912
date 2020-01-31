//
//  ViewController.swift
//  AIR1912
//
//  Created by Infinum on 07/12/2019.
//  Copyright © 2019 Leo Leljak. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    fileprivate let stackView: UIStackView =  {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height - 100).isActive = true
        
        
    }
    
}


