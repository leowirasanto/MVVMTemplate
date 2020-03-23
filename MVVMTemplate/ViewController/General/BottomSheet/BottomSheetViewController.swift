//
//  BottomSheetViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController, BottomSheetDelegate {
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    
    var panelHeight: CGFloat {
        get {
            return 0.0
        } set {
            bottomSheetHeight.constant = newValue
            bottomConstraint.constant = -newValue
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return bottomSheetView.layer.cornerRadius
        } set {
            bottomSheetView.round([.layerMinXMinYCorner, .layerMaxXMinYCorner], newValue)
        }
    }
    
    var childView: UIViewController!
    
    var tapToDismiss: Bool = true
    var onShow: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !onShow {
            setView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setView() {
//        barView.round(barView.bounds.height / 2)
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        dismissGesture.isEnabled = tapToDismiss
        bg.addGestureRecognizer(dismissGesture)
        childView.bottomSheetDelegate = self
        childView.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(childView)
        containerView.addSubview(childView.view)
        childView.didMove(toParent: self)
        
        let top = childView.view.topAnchor.constraint(equalTo: containerView.topAnchor)
        let bottom = childView.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        let leading = childView.view.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        let trailing = childView.view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        bottom.isActive = true
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleDismiss() {
        hidePanel(nil)
    }
    
    @objc func handleSwipe(sender: UIPanGestureRecognizer) {
        let translationY = sender.translation(in: view)
        switch sender.state {
        case .changed:
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y = translationY.y > 0 ? translationY.y : 0
                if translationY.y >= 0, translationY.y <= 100 {
                    self.view.backgroundColor = .clear
                } else if translationY.y >= 100 {
                    guard self.tapToDismiss else {
                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                            self.view.frame.origin.y = 0
                        }, completion: nil)
                        return
                    }
                }
            }, completion: nil)
        case .failed, .cancelled:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y = 0
            }, completion: nil)
        case .ended:
            if translationY.y >= 200 {
                guard tapToDismiss else {
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                        self.view.frame.origin.y = 0
                    }, completion: nil)
                    return
                }
                
                hidePanel(nil)
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.view.frame.origin.y = 0
                }, completion: nil)
            }
        default:
            break
        }
    }
}

extension BottomSheetViewController {
    func updateHeightPanel(height: CGFloat) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.bottomSheetHeight.constant = height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func hidePanel(_ completion: (() -> Void)?) {
        guard tapToDismiss else { return }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.bottomConstraint.constant = -self.bottomSheetHeight.constant
                self.view.layoutIfNeeded()
                self.dismiss(animated: true, completion: completion)
            }, completion: nil)
        }
    }
    
    func showPanel(_ completion: (() -> Void)?) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.bg.alpha = 1
                self.bottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.onShow = true
                completion?()
            })
        }
    }
}
