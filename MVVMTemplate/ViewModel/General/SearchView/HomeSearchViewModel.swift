//
//  HomeSearchViewModel.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation

protocol HomeSearchViewModelProtocol {
    func searchCountry(_ keyword: String)
    var countryDidChanges: ((_ finished: Bool, _ error: Bool) -> Void)? { get set }
}

class HomeSearchViewModel: HomeSearchViewModelProtocol {
    let api = APIService.shared
    var country: [Country]? {
        didSet {
            countryDidChanges?(true, false)
        }
    }

    var countryDidChanges: ((Bool, Bool) -> Void)?

    func searchCountry(_ keyword: String) {
        api.request(endpoint: .searchCountry(param: ["country": keyword])) { result in
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
