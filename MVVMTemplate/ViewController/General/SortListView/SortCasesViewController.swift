//
//  SortCasesViewController.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import Foundation
import UIKit

class SortCasesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var sortView: UIView!
    var handleSelectItem: ((_ type: Sort.CovidCases) -> Void)?
    var options: [String] {
        return [
            Sort.CovidCases.countryAtoZ.rawValue,
            Sort.CovidCases.countryZtoA.rawValue,
            Sort.CovidCases.deathHitoLow.rawValue,
            Sort.CovidCases.deathLowtoHi.rawValue,
            Sort.CovidCases.confirmedHitoLow.rawValue,
            Sort.CovidCases.confirmedLowtoHi.rawValue,
            Sort.CovidCases.recoveredHitoLow.rawValue,
            Sort.CovidCases.recoveredLowtoHi.rawValue
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBottomSheet()
        setView()
    }
    
    private func setView() {
        //table
        tableView.register(cellType: SortCasesTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 42
        tableView.separatorStyle = .none
    }
    
    private func initialBottomSheet() {
        bottomSheetDelegate?.cornerRadius = 20
        bottomSheetDelegate?.panelHeight = 300
        bottomSheetDelegate?.showPanel {
            print("bottom sheet displayed")
        }
    }
}

extension SortCasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(SortCasesTableViewCell.self, indexPath)
        cell.option = options[indexPath.row]
        cell.didSelect = { [weak self] in
            self?.bottomSheetDelegate?.hidePanel {
                self!.handleSelectItem?(Sort.CovidCases(rawValue: self!.options[indexPath.row]) ?? Sort.CovidCases.countryAtoZ)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
