//
//  TabbarViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var myName = ""
    var myID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
        self.navigationController?.isNavigationBarHidden = true
        
        self.tabBar.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if myID != "admin" {
            print("user is not admin")
            self.viewControllers?.remove(at: 3)
        }
    }
    
}
