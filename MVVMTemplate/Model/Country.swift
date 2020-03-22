//
//  Country.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

struct Country {
    var province: String?
    var countryName: String?
    var lastUpdate: String?
    var confirmed: Int = 0
    var deaths: Int = 0
    var recovered: Int = 0
}
