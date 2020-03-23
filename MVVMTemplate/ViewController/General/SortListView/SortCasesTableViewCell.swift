//
//  SortCasesTableViewCell.swift
//  MVVMTemplate
//
//  Created by Leo Wirasanto on 23/03/20.
//  Copyright © 2020 Leo Wirasanto. All rights reserved.
//

import UIKit

class SortCasesTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    var option: String? {
        didSet {
            label.text = option
        }
    }
    var didSelect: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleSelect))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func handleSelect() {
        didSelect?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
