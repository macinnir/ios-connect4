//
//  AwesomeViewController.swift
//  App2
//
//  Created by Robert MacInnis on 8/8/23.
//

import UIKit

class AwesomeViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        
        let tabBar = self.tabBarController!.tabBar
        let crazyItem = tabBar.items![1]
        crazyItem.badgeColor = UIColor.red
        crazyItem.badgeValue = "10"
    }
    
}
