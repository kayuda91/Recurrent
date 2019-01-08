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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
