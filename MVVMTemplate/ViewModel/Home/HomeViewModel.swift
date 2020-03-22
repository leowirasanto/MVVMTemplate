//
//  HomeViewModel.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchCountry()
    var countryDidChanges: ((_ finished: Bool, _ error: Bool) -> Void)? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    var countryDidChanges: ((Bool, Bool) -> Void)?
    var country: [Country]? {
        didSet {
            self.countryDidChanges!(true, false)
        }
    }

    func fetchCountry() {
        let dummyData: [Country] = [
            Country(province: "Jakarta", countryName: "Indonesia", lastUpdate: "2020-03-21T21:13:30", confirmed: 304, deaths: 48, recovered: 29),
            Country(province: "Wuhan", countryName: "China", lastUpdate: "2020-03-21T21:13:30", confirmed: 20000, deaths: 1048, recovered: 940),
            Country(province: "Rome", countryName: "Italy", lastUpdate: "2020-03-21T21:13:30", confirmed: 1003, deaths: 508, recovered: 29)
        ]

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.country = dummyData
        }

        // if error just call
        // countryDidChanges!(false, true)
    }
}
