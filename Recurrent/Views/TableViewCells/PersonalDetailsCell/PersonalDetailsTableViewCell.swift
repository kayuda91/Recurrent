//
//  PersonalDetailsTableViewCell.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/17/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class PersonalDetailsTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    var title: String? {
        didSet {
            detailsLabel.text = title ?? ""
        }
    }
    
    var inputValue: String? {
        didSet {
            detailsTextField.text = inputValue ?? ""
        }
    }
    
    var isNumericOnly: Bool = false {
        didSet {
            detailsTextField.keyboardType = isNumericOnly ? .numberPad : .default
        }
    }
    
    var textFieldEndEditing: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailsTextField.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title = ""
        inputValue = ""
    }
}

// MARK: - UITextFieldDelegate
extension PersonalDetailsTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEndEditing?(textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let inputText = textField.text else {
            return false
        }
        
        let shouldChangeCharacter = !(isNumericOnly && inputText.count > 4 && range.length == 0)
        
        if !shouldChangeCharacter { textField.resignFirstResponder() }
        return shouldChangeCharacter
    }
}
