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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureUI() {
        continueButton.roundCorners(radius: 3)
        continueButton.layer.masksToBounds = false
        continueButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                       offset: CGSize(width: 5, height: 5),
                                       opacity: 0.5,
                                       radius: 5)
    }
}
