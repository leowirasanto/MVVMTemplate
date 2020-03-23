//
//  CountryDetailViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let vm = CountryDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        prepareObserver()
    }
    
    func setupView() {
        // tableview
        tableView.register(cellType: HomeTableViewCell.self)
        tableView.register(cellType: CountryDetailTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CountryDetailViewController {
    func fetchData() {
        vm.fetchData()
    }
    
    func prepareObserver() {
        vm.countryDidChanges = { _, _ in
            if let c = self.vm.selectedCountry {
                self.vm.country = self.vm.country?.relatedCountry(country: c)
            }
            self.tableView.reloadData()
        }
    }
}

extension CountryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return 111
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return vm.country?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusable(CountryDetailTableViewCell.self, indexPath)
            cell.country = vm.selectedCountry
            return cell
        } else {
            let cell = tableView.dequeueReusable(HomeTableViewCell.self, indexPath)
            cell.country = vm.country?[indexPath.row]
            cell.handleSelect = { [weak self] in
                guard let countries = self?.vm.country?[indexPath.row] else { return }
                let detail = CountryDetailViewController()
                detail.vm.selectedCountry = countries
                detail.vm.country = self?.vm.country
                self?.navigate(.pushWithHideBottomBar, detail)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
