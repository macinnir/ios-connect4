//
//  CustomTabBarController.swift
//  App2
//
//  Created by Robert MacInnis on 8/8/23.
//

import UIKit

class CustomTabBarController : UITabBarController {
    @IBInspectable var initialIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = initialIndex
    }
}
