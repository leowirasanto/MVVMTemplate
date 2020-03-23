//
//  HomeSearchViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let vm = HomeSearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        prepareObserver()
    }

    private func setView() {
        //tableView
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 111
        tableView.register(cellType: HomeTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        // item bar
        let sortBtn = UIBarButtonItem(image: Images.NavigationItem.sort, style: .done, target: self, action: #selector(handleSort(_:)))
        navigationItem.rightBarButtonItems = [sortBtn]
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
}

extension HomeSearchViewController {
    func prepareObserver() {
        vm.countryDidChanges = { _, error in
            self.hidePopupAnimation()
            if !error {
                self.tableView.reloadData()
            }
        }
    }

    func search(_ keyword: String) {
        showPopupAnimation(view.bounds.width, animationName: Constant.AnimationNames.virusAnimation)
        vm.searchCountry(keyword)
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.country?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(HomeTableViewCell.self, indexPath)
        cell.country = vm.country?[indexPath.row]
        return cell
    }
}

extension HomeSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text {
            search(keyword)
        }
        searchBar.endEditing(true)
    }
}
