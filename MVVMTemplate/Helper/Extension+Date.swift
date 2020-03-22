//
//  Extension+Date.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

extension Date {
    func convertDateToString(_ format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let stringDate = formatter.string(from: self)
        return stringDate
    }
}
