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
    
    // MARK: - @IBAction
    @IBAction func navigateBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueRegistration(_ sender: UIButton) {
        //TODO: Push next VC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
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
}
