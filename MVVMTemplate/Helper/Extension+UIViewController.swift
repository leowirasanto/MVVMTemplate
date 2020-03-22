//
//  Extension+UIViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigation(_ title: String = "", _ tintColor: UIColor = .white, _ barColor: UIColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)) {
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        self.title = title
    }
    
    // Use this function to change page, instead of using manual present or push view controllers
    func navigate(_ type: NavigateType = .pushWithHideBottomBar, _ controller: UIViewController) {
        switch type {
        case .push:
            if let navigation = self.navigationController {
                navigation.pushViewController(controller, animated: true)
            }
        case .pushWithHideBottomBar:
            if let navigation = self.navigationController {
                controller.hidesBottomBarWhenPushed = true
                navigation.pushViewController(controller, animated: true)
            }
        case .root:
            UIApplication.shared.delegate?.window??.setRootViewController(controller)
        case .present:
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension UIWindow {
    func setRootViewController(_ controller: UIViewController) {
        self.rootViewController = controller
    }
}
