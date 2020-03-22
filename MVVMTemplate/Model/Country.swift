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
