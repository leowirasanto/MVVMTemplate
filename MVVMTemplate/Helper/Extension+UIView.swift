//
//  Extension+UIView.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func round(_ corner: CGFloat = 10) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = corner
    }
    
    func dropShadow() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
}
