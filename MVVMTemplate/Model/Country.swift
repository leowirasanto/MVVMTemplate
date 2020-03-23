//
//  Country.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Country {
    var province: String?
    var countryName: String?
    var lastUpdate: String?
    var confirmed: Int = 0
    var deaths: Int = 0
    var recovered: Int = 0

    init(data: JSON) {
        if let value = data["deaths"].int {
            self.deaths = value
        }
        if let value = data["country"].string {
            self.countryName = value
        }
        if let value = data["recovered"].int {
            self.recovered = value
        }
        if let value = data["confirmed"].int {
            self.confirmed = value
        }
        if let value = data["province"].string {
            self.province = value
        }
        if let value = data["lastUpdate"].string {
            self.lastUpdate = value
        }
    }
}

extension Array where Element == Country {
    func sortByCountryNameAtoZ() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            (a.countryName ?? "") < (b.countryName ?? "")
        }
    }

    func sortByCountryNameZtoA() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            (a.countryName ?? "") > (b.countryName ?? "")
        }
    }

    func sortConfirmedHighestToLowest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.confirmed > b.confirmed
        }
    }

    func sortConfirmedLowestToHighest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.confirmed < b.confirmed
        }
    }

    func sortDeathHighestToLowest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.deaths > b.deaths
        }
    }
    
    func sortDeathLowestToHighest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.deaths < b.deaths
        }
    }
    
    func sortRecoveredHighestToLowest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.recovered > b.recovered
        }
    }
    
    func sortRecoveredLowestToHighest() -> [Country] {
        return self.sorted { (a, b) -> Bool in
            a.recovered < b.recovered
        }
    }
}
