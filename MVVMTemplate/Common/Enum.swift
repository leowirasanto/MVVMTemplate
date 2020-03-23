//
//  Enum.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

enum NavigateType {
    case push
    case pushWithHideBottomBar
    case root
    case present
}

struct Sort {
    enum CovidCases: String {
        case countryAtoZ = "Country A-Z"
        case countryZtoA = "Country Z-A"
        case deathHitoLow = "Death Highest-Lowest"
        case deathLowtoHi = "Death Lowest-Highest"
        case confirmedHitoLow = "Confirmed Highest-Lowest"
        case confirmedLowtoHi = "Confirmed Lowest-Highest"
        case recoveredHitoLow = "Recovered Highest-Lowest"
        case recoveredLowtoHi = "Recovered Lowest-Highest"
    }
} 

