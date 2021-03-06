//
//  PersonalDetailsViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/17/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class PersonalDetailsViewController: UIViewController {
    @IBOutlet weak var continueUIButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var firstName: String?
    var lastName: String?
    
    var detailsSections = DetailsSectionType.getCases()
    
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
        saveDetails()
        navigateToHomeAddressScreen()
    }
    
     // MARK: - UI Configuration
    func configureUI() {
        continueUIButton.roundCorners(radius: 3)
        continueUIButton.layer.masksToBounds = false
        continueUIButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                       offset: CGSize(width: 5, height: 5),
                                       opacity: 0.5,
                                       radius: 5)
    }
    
    func saveDetails() {
        guard firstName != nil, firstName != "",
            lastName != nil, lastName != "" else {
            showAlert(message: "Please fill up your details")
            return
        }
        
        UserDefaults.standard.set(firstName,
                                  forKey: UserDefaultKeys.firstName)
        UserDefaults.standard.set(lastName,
                                  forKey: UserDefaultKeys.lastName)
    }
    
    // MARK: - TableView configuration
    func configureTableView() {
        tableView.register(PersonalDetailsTableViewCell.self)
    }
    
    // MARK: - Navigation
    func navigateToHomeAddressScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeAddressViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Section definition
extension PersonalDetailsViewController {
    enum DetailsSectionType: Int {
        case firstName
        case lastName
        
        var title: String {
            switch self {
            case .firstName: return "Legal first name"
            case .lastName: return "Legal last name"
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PersonalDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: PersonalDetailsTableViewCell.self)
        cell.title = detailsSections[indexPath.section].title
        cell.inputValue = indexPath.section == 0 ? firstName : lastName
        
        cell.textFieldEndEditing = { text in
            if indexPath.section == 0 {
                self.firstName = text
            } else {
                self.lastName = text
            }
        }
        
        return cell
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
