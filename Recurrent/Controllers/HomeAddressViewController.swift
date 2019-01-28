//
//  HomeAddressViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeAddressViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var addressSections = AddressSectionType.getCases()
    var selectedCountry = Countries.usa
    var selectedState: String?
    var zipCode: String?
    var addressLine1: String?
    var addressLine2: String?
    var city: String?
    
    var pickerView = UIPickerView()
    var pickerToolbar = UIToolbar()
    var isPickerForCountries: Bool = true
    lazy var databaseService = DatabaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - @IBAction
    @IBAction func navigateBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueRegistration(_ sender: UIButton) {
        guard zipCode != nil, addressLine1 != nil, city != nil,
            zipCode != "", addressLine1 != "", city != "" else {
                showAlert(message: "Please fill up all required fields")
                return
        }
        
        saveInfo()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        continueButton.roundCorners(radius: 3)
        continueButton.layer.masksToBounds = false
        continueButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                         offset: CGSize(width: 5, height: 5),
                                         opacity: 0.5,
                                         radius: 5)
    }
    
    // MARK: - Picker configuration
    func configurePickerView(isCountrySelected: Bool) {
        self.pickerView = UIPickerView(frame: CGRect(x: 0,
                                                            y: self.view.frame.size.height - 216 + 36,
                                                            width: self.view.frame.size.width,
                                                            height: 216 - 36))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pickerView.showsSelectionIndicator = true
        
        pickerToolbar = UIToolbar(frame: CGRect(x: 0,
                                                       y: self.view.frame.size.height - 216,
                                                       width: self.view.frame.size.width,
                                                       height: 36))
        
        pickerToolbar.barStyle = .default
        pickerToolbar.isTranslucent = true
        pickerToolbar.tintColor = #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        pickerToolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        pickerToolbar.isUserInteractionEnabled = true
        
        self.view.addSubview(pickerView)
        self.view.addSubview(pickerToolbar)
    }
    
    @objc func doneClick() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        
        if isPickerForCountries {
            let sortedCountries = Countries.getCases().sorted {$0.name < $1.name}
            selectedCountry = sortedCountries[selectedRow]
            selectedState = selectedCountry.states.first
        } else {
            let sortedStates = selectedCountry.states.sorted {$0 < $1}
            selectedState = sortedStates[selectedRow]
        }
        
        removePicker()
        tableView.reloadData()
    }
    
    @objc func cancelClick() {
        removePicker()
    }
    
    func removePicker() {
        pickerToolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
    
    // MARK: - Navigation
    func navigateToRegConfirmationVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegConfirmationViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - TableView configuration
    func configureTableView() {
        tableView.register(PersonalDetailsTableViewCell.self)
        tableView.register(HomeAddressTableViewCell.self)
    }
}

// MARK: - API Communication methods
extension HomeAddressViewController {
    func saveInfo() {
        activityIndicator.startAnimating()
        if UserDefaults.standard.value(forKey: UserDefaultKeys.userSignedIn) == nil && Auth.auth().currentUser != nil {
            databaseService.signOut { success, error in
                guard success else {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(message: error?.localizedDescription ?? "Couldn't sign out previous user")
                    return
                }
            }
        }
        
        self.databaseService.signInAnonymously { user, error in
            let defaults = UserDefaults.standard
            guard let user = user,
                let phoneNumber = defaults.object(forKey: UserDefaultKeys.phoneNumber) as? String,
                let firstName = defaults.object(forKey: UserDefaultKeys.firstName) as? String,
                let lastName = defaults.object(forKey: UserDefaultKeys.lastName) as? String,
                let passcode = defaults.object(forKey: UserDefaultKeys.passcode) as? String else {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(message: error?.localizedDescription ?? "Couldn't fetch user data")
                    return
            }
            
            user.phoneNumber = phoneNumber
            user.passcode = passcode
            user.firstName = firstName
            user.lastName = lastName
            user.country = self.selectedCountry.name
            user.zipCode = self.zipCode
            user.addressLine1 = self.addressLine1
            user.addressLine2 = self.addressLine2
            user.city = self.city
            user.state = self.selectedState
            user.createdAt = Timestamp(date: Date())
            
            self.databaseService.save(user: user, completion: { success, error in
                guard success else {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(message: error?.localizedDescription ?? "Couldn't save user info")
                    return
                }
                
                defaults.set(true, forKey: UserDefaultKeys.userSignedIn)
                self.activityIndicator.stopAnimating()
                self.navigateToRegConfirmationVC()
            })
        }
    }
}

// MARK: - Section definition
extension HomeAddressViewController {
    enum AddressSectionType: Int {
        case country
        case zipCode
        case addressLine1
        case addressLine2
        case city
        case state
        
        var isOptional: Bool {
            switch self {
            case .addressLine2: return true
            default: return false
            }
        }
        
        var isDropDown: Bool {
            switch self {
            case .country, .state: return true
            default: return false
            }
        }
        
        var isNumericOnly: Bool {
            switch self {
            case .zipCode: return true
            default: return false
            }
        }
        
        var title: String {
            switch self {
            case .country: return "Country"
            case .zipCode: return "Zip code"
            case .addressLine1: return "Address Line 1"
            case .addressLine2: return "Address Line 2 (optional)"
            case .city: return "City"
            case .state: return "State"
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return addressSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == addressSections.count - 1 {
            return dropDownCell(tableView, at: indexPath, isCountrySelected: indexPath.section == 0)
        } else {
            return textFieldCell(tableView, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: - TableView Helpers
private extension HomeAddressViewController {
    func textFieldCell(_ tableView: UITableView, at indexPath: IndexPath) -> PersonalDetailsTableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: PersonalDetailsTableViewCell.self)
        let section = addressSections[indexPath.section]
        
        cell.title = section.title
        cell.isNumericOnly = section.isNumericOnly
        
        let editedSection = self.addressSections[indexPath.section]
        switch editedSection {
        case .zipCode:
            cell.inputValue = zipCode
        case .addressLine1:
            cell.inputValue = addressLine1
        case .addressLine2:
            cell.inputValue = addressLine2
        case .city:
            cell.inputValue = city
        default:
            break
        }
        
        cell.textFieldEndEditing = { text in
            switch editedSection {
            case .zipCode:
                self.zipCode = text
            case .addressLine1:
                self.addressLine1 = text
            case .addressLine2:
                self.addressLine2 = text
            case .city:
                self.city = text
            default:
                break
            }
        }
        
        return cell
    }
    
    func dropDownCell(_ tableView: UITableView, at indexPath: IndexPath, isCountrySelected: Bool) -> HomeAddressTableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: HomeAddressTableViewCell.self)
        let section = addressSections[indexPath.section]
        cell.title = section.title
        cell.inputValue = isCountrySelected ? selectedCountry.name : selectedState ?? selectedCountry.states.first
        self.isPickerForCountries = isCountrySelected
        
        cell.onDropDownPressed = {
            self.configurePickerView(isCountrySelected: isCountrySelected)
        }
        
        return cell
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension HomeAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isPickerForCountries ? Countries.count : selectedCountry.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isPickerForCountries {
            let sortedCountries = Countries.getCases().sorted {$0.name < $1.name}
            let country = sortedCountries[row]
            return country.name
        } else {
            let sortedStates = selectedCountry.states.sorted {$0 < $1}
            return sortedStates[row]
        }
    }
}
