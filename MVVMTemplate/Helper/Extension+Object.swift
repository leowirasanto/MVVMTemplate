//
//  Extension+Object.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
