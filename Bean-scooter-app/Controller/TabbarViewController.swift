//
//  TabbarViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var myID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
        self.navigationController?.isNavigationBarHidden = true
        
        self.tabBar.backgroundColor = .white
        
        if myID != "admin" {
            self.viewControllers?.remove(at: 3)
        }
    }

}
