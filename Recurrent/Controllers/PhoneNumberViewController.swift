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
    @IBOutlet weak var countryUnderlineLabel: UILabel!
    
    @IBOutlet weak var phoneNumbertextField: UITextField!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var phoneNumberUnderlineLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var countryPickerView = UIPickerView()
    var countryPickerToolbar = UIToolbar()
    var inputPhoneNumber: String = ""
    
    var selectedCountry = Countries.getCases()[0] {
        didSet {
            countryCodeButton.setTitle("+" + selectedCountry.phoneCode, for: .normal)
        }
    }
    
    var isPhoneNumberFieldSelected = true {
        didSet {
            countryTitleLabel.textColor = isPhoneNumberFieldSelected ? #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5333333333, blue: 0.9490196078, alpha: 1)
            countryUnderlineLabel.backgroundColor = isPhoneNumberFieldSelected ? #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5333333333, blue: 0.9490196078, alpha: 1)
            
            phoneNumberTitleLabel.textColor = !isPhoneNumberFieldSelected ? #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5333333333, blue: 0.9490196078, alpha: 1)
            phoneNumberUnderlineLabel.backgroundColor = !isPhoneNumberFieldSelected ? #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1) : #colorLiteral(red: 0.2509803922, green: 0.5333333333, blue: 0.9490196078, alpha: 1)
        }
    }
    
    lazy var databaseService = DatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        hideKeyboardWhenTappedAround()
        phoneNumbertextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - @IBAction
    @IBAction func chooseCountry(_ sender: UIButton) {
        isPhoneNumberFieldSelected = false
        configurePickerView()
    }
    
    @IBAction func continueRegistration(_ sender: UIButton) {
        activityIndicator.startAnimating()
        guard phoneNumbertextField.text?.count == selectedCountry.numberLength else {
            activityIndicator.stopAnimating()
            self.showAlert(message: "Please enter valid phone number containing \(selectedCountry.numberLength) digits")
            return
        }
        
        validatePhoneNumber { success in
            guard success else {
                self.activityIndicator.stopAnimating()
                self.showAlert(message: "This phone number is already registered.")
                return
            }
            
            //TODO: Save new user
            print("Success")
        }
    }
    
    // MARK: - UI configuration
    func configureUI() {
        continueButton.roundCorners(radius: 3)
        continueButton.layer.masksToBounds = false
        continueButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                       offset: CGSize(width: 5, height: 5),
                                       opacity: 0.5,
                                       radius: 5)
        configureTextField()
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
        
        countryPickerToolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height - 216,
                                              width: self.view.frame.size.width,
                                              height: 36))
        countryPickerToolbar.barStyle = .default
        countryPickerToolbar.isTranslucent = true
        countryPickerToolbar.tintColor = #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1)

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
        selectedCountry = sortedCountries[selectedRow]
        removeCountryPicker()
    }
    
    @objc func cancelClick() {
        removeCountryPicker()
    }
    
    func removeCountryPicker() {
        countryPickerToolbar.removeFromSuperview()
        countryPickerView.removeFromSuperview()
    }
    
    func configureTextField() {
        phoneNumbertextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Navigation
    func navigateToPersonalDetailsController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PasscodeViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Database communication
    func validatePhoneNumber(completion: @escaping (Bool) -> Void) {
        databaseService.fetchUsers(completion: { [weak self] users, error in
            guard let users = users else {
                 self?.showAlert(message: error?.localizedDescription ?? "Error")
                return
            }
            
            users.forEach { user in
                guard let fetchedPhoneNumber = user.phoneNumber, let enteredNumber = self?.inputPhoneNumber,
                let countryCode = self?.selectedCountry.phoneCode else {
                    self?.showAlert(message: "Couldn't fetch number")
                    completion(false)
                    return
                }
                
                if fetchedPhoneNumber == countryCode + enteredNumber {
                    completion(false)
                }
            }
            
            completion(true)
        })
    }
    
    func savePhoneNumber(completion: @escaping (Bool) -> Void) {
        
    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isPhoneNumberFieldSelected = true
        phoneNumberTitleLabel.isHidden = textField.text?.count ?? 0 < 1
        removeCountryPicker()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let inputNumber = textField.text else {
            return false
        }
        
        phoneNumberTitleLabel.isHidden = range.location < 1 && string == ""
        
        let shouldUpdateNumber = !(inputNumber.count > selectedCountry.numberLength && range.length == 0)
        let shouldChangeCharacter = !(inputNumber.count >= selectedCountry.numberLength && range.length == 0)
        
        if shouldUpdateNumber { inputPhoneNumber = inputNumber + string }
        if !shouldChangeCharacter {
            textField.resignFirstResponder()
        }
        
        return shouldChangeCharacter
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let inputNumber = textField.text else {
            return
        }
        
        if inputNumber.count >= selectedCountry.numberLength {
            textField.resignFirstResponder()
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
        return "+" + country.phoneCode + " " + country.name
    }
}
