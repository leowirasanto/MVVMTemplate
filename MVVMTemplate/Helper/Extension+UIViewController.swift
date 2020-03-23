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
    private struct UniqueIdProperies {
        static var bottomSheetDelegate: BottomSheetDelegate?
    }

    func setNavigation(_ title: String = "", _ tintColor: UIColor = .white, _ barColor: UIColor = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)) {
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

    weak var bottomSheetDelegate: BottomSheetDelegate? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.bottomSheetDelegate) as? BottomSheetDelegate
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.bottomSheetDelegate, unwrappedValue as BottomSheetDelegate?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
}

extension UIWindow {
    func setRootViewController(_ controller: UIViewController) {
        self.rootViewController = controller
    }
}

protocol BottomSheetDelegate: class {
    func updateHeightPanel(height: CGFloat)
    func hidePanel(_ completion: (() -> Void)?)
    func showPanel(_ completion: (() -> Void)?)
    var panelHeight: CGFloat { get set }
    var tapToDismiss: Bool { get set }
    var cornerRadius: CGFloat { get set }
}
