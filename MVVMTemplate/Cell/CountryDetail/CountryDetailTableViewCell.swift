//
//  CountryDetailTableViewCell.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit
import Lottie

class CountryDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var animContainer: UIView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var confirmed: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var recovered: UILabel!
    @IBOutlet weak var lastupdate: UILabel!
    var country: Country? {
        didSet {
            var provinceName: String
            if country?.province ?? "" == "" {
                provinceName = ""
            } else {
                provinceName = "(\(country?.province ?? ""))"
            }
            countryName.text = "\(country?.countryName ?? "") \(provinceName)"
            deaths.text = "\(country?.deaths ?? 0)"
            recovered.text = "\(country?.recovered ?? 0)"
            confirmed.text = "\(country?.confirmed ?? 0)"
            //format from 2020-03-23T06:02:35.247Z
            lastupdate.text = "Last update : \(country?.lastUpdate?.formatStringDate(with: "yyyy-MM-dd'T'HH:mm:ss", to: "dd MMM yyyy, HH:mm") ?? "-")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        animContainer.addLottieAnimation(animationName: Constant.AnimationNames.sickAnimation)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
