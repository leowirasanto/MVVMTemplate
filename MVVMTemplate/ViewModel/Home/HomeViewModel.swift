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
    let api = APIService.shared
    var countryDidChanges: ((Bool, Bool) -> Void)?
    var country: [Country]? {
        didSet {
            countryDidChanges!(true, false)
        }
    }

    func fetchCountry() {
        api.request(endpoint: .getCountry) { result in
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
                self.countryDidChanges!(false, true)
            }
        }
    }
}
