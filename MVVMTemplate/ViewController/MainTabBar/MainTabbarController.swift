//
//  MainTabbarController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {
    private var home = HomeViewController()
    private var profile = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home.tabBarItem = UITabBarItem(title: "Home", image: Images.TabBar.home, tag: 0)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: Images.TabBar.profile, tag: 1)
        let childs = [home, profile].map {
            UINavigationController(rootViewController: $0)
        }
        viewControllers = childs
    }
}
