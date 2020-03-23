//
//  Extension+UIViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import Lottie
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

// handle show popup
extension UIViewController {
    func showPopupAnimation(_ width: CGFloat = 150, _ height: CGFloat = 150, animationName: String = Constant.AnimationNames.virusAnimation) {
        let animationContainer = UIView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
        let animationView = AnimationView()
        animationContainer.tag = 111
        animationContainer.round()
        animationContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(animationContainer)
        self.view.bringSubviewToFront(animationContainer)

        NSLayoutConstraint.activate([
            animationContainer.widthAnchor.constraint(equalToConstant: width),
            animationContainer.heightAnchor.constraint(equalToConstant: height),
            animationContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            animationContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])

        animationView.animation = Animation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.loopMode = .loop

        animationContainer.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: animationContainer.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationContainer.bottomAnchor),
            animationView.leftAnchor.constraint(equalTo: animationContainer.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: animationContainer.rightAnchor),
        ])

        animationView.play()
    }
    
    func hidePopupAnimation() {
        self.view.subviews.forEach { (view) in
            if view.tag == 111 {
                view.removeFromSuperview()
            }
        }
    }
}
