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

        // item bar
        let sortBtn = UIBarButtonItem(image: Images.NavigationItem.sort, style: .done, target: self, action: #selector(handleSort(_:)))
        let searchBtn = UIBarButtonItem(image: Images.NavigationItem.search, style: .done, target: self, action: #selector(handleSearch(_:)))
        navigationItem.rightBarButtonItems = [searchBtn, sortBtn]
    }

    @objc func handleSort(_ sender: Any) {
        let sortVC = SortCasesViewController()
        sortVC.handleSelectItem = { [weak self] option in
            switch option {
            case .countryAtoZ:
                self?.vm.country = self?.vm.country?.sortByCountryNameAtoZ()
            case .countryZtoA:
                self?.vm.country = self?.vm.country?.sortByCountryNameZtoA()
            case .deathHitoLow:
                self?.vm.country = self?.vm.country?.sortDeathHighestToLowest()
            case .deathLowtoHi:
                self?.vm.country = self?.vm.country?.sortDeathLowestToHighest()
            case .confirmedHitoLow:
                self?.vm.country = self?.vm.country?.sortConfirmedHighestToLowest()
            case .confirmedLowtoHi:
                self?.vm.country = self?.vm.country?.sortConfirmedLowestToHighest()
            case .recoveredHitoLow:
                self?.vm.country = self?.vm.country?.sortRecoveredHighestToLowest()
            case .recoveredLowtoHi:
                self?.vm.country = self?.vm.country?.sortRecoveredLowestToHighest()
            }
        }
        let bottomSheet = BottomSheetViewController()
        bottomSheet.childView = sortVC
        navigate(.present, bottomSheet)
    }

    @objc func handleSearch(_ sender: Any) {
        navigate(.pushWithHideBottomBar, HomeSearchViewController())
    }
}

extension HomeViewController {
    func fetchCountryData() {
        showPopupAnimation(view.bounds.width, animationName: Constant.AnimationNames.virusAnimation)
        vm.fetchCountry()
    }

    // function to observe homeviewmodel
    func prepareViewModelObserver() {
        vm.countryDidChanges = { _, error in
            self.hidePopupAnimation()
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
