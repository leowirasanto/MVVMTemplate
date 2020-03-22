//
//  Extension+String.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

extension String {
    func formatStringDate(with initialDateFormat: String = "yyyy-MM-dd HH:mm:ss", to dateFormat: String = "dd MMMM yy HH:mm") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = initialDateFormat
        let _date = formatter.date(from: self)
        formatter.dateFormat = dateFormat
        if let date = _date {
            let _strDate = formatter.string(from: date)
            return _strDate
        }
        return nil
    }
    
    func toDate(with initialFormat: String = "yyyy-MM-dd HH:mm") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = initialFormat
        let date = formatter.date(from: self)
        return date
    }
    
    func className() -> String {
        return "Class '\(self)'"
    }
    
    func toMoment() -> String {
        return "Last online 1 minute ago"
    }
}
