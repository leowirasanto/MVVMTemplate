//
//  HomeViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let vm = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation("Home")
        setupView()
        prepareViewModelObserver()
        fetchCountryData()
        
    }

    private func setupView() {
        // tableview
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 111
        tableView.register(cellType: HomeTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController {
    func fetchCountryData() {
        vm.fetchCountry()
    }
    
    func prepareViewModelObserver() {
        vm.countryDidChanges = { (finished, error) in
            if !error {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.country?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(HomeTableViewCell.self, indexPath)
        cell.country = vm.country?[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected at \(indexPath.row)")
    }
}
