//
//  Extension+UITableView.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
           let name = cellType.className
           let nib = UINib(nibName: name, bundle: bundle)
           register(nib, forCellReuseIdentifier: name)
       }
       
       func dequeueReusable<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
           return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
       }
}
