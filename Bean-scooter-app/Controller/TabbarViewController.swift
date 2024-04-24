//
//  TabbarViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedIndex = 0
        self.navigationController?.isNavigationBarHidden = false
    }


    
}
