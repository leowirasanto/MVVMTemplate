//
//  Extension+UIView.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension UIView {
    func round(_ corner: CGFloat = 10) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corner
    }
    
    func round(_ specificCorner: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner], _ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = specificCorner
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    func dropShadow() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
    
    func addLottieAnimation(animationName: String = Constant.AnimationNames.virusAnimation, with tag_: Int = 111) {
        let animationView = AnimationView()
        animationView.tag = tag_
        animationView.animation = Animation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.loopMode = .loop

        self.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: self.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            animationView.leftAnchor.constraint(equalTo: self.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        animationView.play()
    }
    
    func removeLottieAnimation(with tag_: Int) {
        self.subviews.forEach { v in
            if v.tag == tag_ {
                v.removeFromSuperview()
            }
        }
    }
}
