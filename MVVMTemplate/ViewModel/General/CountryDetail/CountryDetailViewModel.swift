//
//  CountryDetailViewModel.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CountryDetailViewModelProtocol {
    func fetchData()
    var countryDidChanges: ((Bool, Bool) -> Void)? { get set }
}

class CountryDetailViewModel: CountryDetailViewModelProtocol {
    let api = APIService.shared
    var selectedCountry: Country?
    var country: [Country]? {
        didSet {
            countryDidChanges?(true, false)
        }
    }

    var countryDidChanges: ((Bool, Bool) -> Void)?

    func fetchData() {
        api.request(endpoint: .searchCountry(param: ["country": selectedCountry?.countryName ?? ""])) { result in
            switch result {
            case .success(let json):
                guard let error = json["error"].bool, error == false else {
                    self.countryDidChanges!(false, true)
                    return
                }
                if json["data"].exists() {
                    if let countries = json["data"]["covid19Stats"].array {
                        var tempCountries: [Country] = []
                        countries.forEach { json in
                            tempCountries.append(Country(data: json))
                        }
                        if let current = tempCountries.filter({ (country) -> Bool in
                            (country.countryName == self.selectedCountry?.countryName) && (country.province == self.selectedCountry?.province)
                        }).first {
                            self.selectedCountry = current
                        }
                        self.country = tempCountries
                    }
                } else {
                    self.countryDidChanges!(false, true)
                }
                print("Get country Result : \(json)")
            case .failure(let error):
                print(error.localizedDescription)
                self.countryDidChanges?(false, true)
            }
        }
    }
}
