//
//  HomeTableViewCell.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 22/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var curedLbl: UILabel!
    @IBOutlet weak var deathLbl: UILabel!
    @IBOutlet weak var positiveLbl: UILabel!
    
    var country: Country? {
        didSet {
            var provinceName: String
            if country?.province ?? "" == "" {
                provinceName = ""
            } else {
                provinceName = "(\(country?.province ?? ""))"
            }
            countryName.text = "\(country?.countryName ?? "") \(provinceName)"
            deathLbl.text = "\(country?.deaths ?? 0)"
            curedLbl.text = "\(country?.recovered ?? 0)"
            positiveLbl.text = "\(country?.confirmed ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
