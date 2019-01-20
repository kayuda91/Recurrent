//
//  HomeAddressTableViewCell.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class HomeAddressTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var addressTitleLabel: UILabel!
    @IBOutlet private weak var addressValueLabel: UILabel!
    
    var title: String? {
        didSet {
            addressTitleLabel.text = title ?? ""
        }
    }
    
    var inputValue: String? {
        didSet {
            addressValueLabel.text = inputValue ?? ""
        }
    }
    
    @objc var onDropDownPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindGestures()
    }
}

// MARK: - Gestures
private extension HomeAddressTableViewCell {
    func bindGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        self.onDropDownPressed?()
    }
}
