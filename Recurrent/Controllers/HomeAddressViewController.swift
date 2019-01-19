//
//  HomeAddressViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class HomeAddressViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    var addressSections = AddressSectionType.getCases()

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
        //TODO: Navigate to next VC
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
    
    // MARK: - TableView configuration
    func configureTableView() {
        tableView.register(PersonalDetailsTableViewCell.self)
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
            case .addressLine2: return "Address Line 2"
            case .city: return "City"
            case .state: return "State"
            }
        }
    }
}
