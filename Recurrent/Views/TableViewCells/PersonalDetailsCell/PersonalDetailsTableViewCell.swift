//
//  PersonalDetailsTableViewCell.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/17/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var detailsTextField: UITextField!
    
    var title: String? {
        didSet {
            detailsLabel.text = title ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
