//
//  PhoneNumberViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/7/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    @IBOutlet weak var countryScoreUnderlineLabel: UILabel!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryTitleLabel: UILabel!
    
    @IBOutlet weak var phoneNumberUnderlineLabel: UILabel!
    @IBOutlet weak var phoneNumbertextField: UITextField!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func chooseCountry(_ sender: UIButton) {
        configurePickerView()
    }
    
    var countryPickerView = UIPickerView()
    var countryPickerToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - UI configuration
    func configureUI() {
        continueButton.roundCorners(radius: 3)
        continueButton.layer.masksToBounds = false
        continueButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                       offset: CGSize(width: 5, height: 5),
                                       opacity: 0.5,
                                       radius: 5)
    }
    
    func configurePickerView() {
        self.countryPickerView = UIPickerView(frame: CGRect(x: 0,
                                                            y: self.view.frame.size.height - 216 + 36,
                                                       width: self.view.frame.size.width,
                                                       height: 216 - 36))
        countryPickerView.showsSelectionIndicator = true
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // ToolBar
        countryPickerToolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height - 216,
                                              width: self.view.frame.size.width,
                                              height: 36))
        countryPickerToolbar.barStyle = .default
        countryPickerToolbar.isTranslucent = true
        countryPickerToolbar.tintColor = #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1)

        // Adding ToolBar Buttons
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        countryPickerToolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        countryPickerToolbar.isUserInteractionEnabled = true
        
        self.view.addSubview(countryPickerView)
        self.view.addSubview(countryPickerToolbar)
    }
    
    @objc func doneClick() {
        let selectedRow = countryPickerView.selectedRow(inComponent: 0)
        let sortedCountries = Countries.getCases().sorted {$0.name < $1.name}
        let countryCode = sortedCountries[selectedRow].phoneCode
        countryCodeButton.setTitle("+" + String(countryCode), for: .normal)
        countryPickerToolbar.removeFromSuperview()
        countryPickerView.removeFromSuperview()
    }
    
    @objc func cancelClick() {
        countryPickerToolbar.removeFromSuperview()
        countryPickerView.removeFromSuperview()
    }
}

// MARK: - Countries Codes definition
extension PhoneNumberViewController {
    enum Countries: Int {
        case ukraine
        case usa
        case checkRepublic
        case japan
        case uk
        case mexico
        case australia
        
        var name: String {
            switch self {
            case .ukraine: return "Ukraine"
            case .usa: return "USA"
            case .checkRepublic: return "Check Republic"
            case .japan: return "Japan"
            case .uk: return "UK"
            case .mexico: return "Mexico"
            case .australia: return "Australia"
            }
        }
        
        var phoneCode: Int {
            switch self {
            case .ukraine: return 380
            case .usa: return 1
            case .checkRepublic: return 420
            case .japan: return 81
            case .uk: return 44
            case .mexico: return 52
            case .australia: return 61
            }
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension PhoneNumberViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sortedCountries = Countries.getCases().sorted {$0.name < $1.name}
        let country = sortedCountries[row]
        return "+" + String(country.phoneCode) + " " + country.name
    }
}
