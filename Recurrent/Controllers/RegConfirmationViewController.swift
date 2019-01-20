//
//  RegConfirmationViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class RegConfirmationViewController: UIViewController {
    @IBOutlet weak var gotItButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func confirmRegistration(_ sender: UIButton) {
        showQueueInfoVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        gotItButton.roundCorners(radius: 3)
        gotItButton.layer.masksToBounds = false
        gotItButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                       offset: CGSize(width: 5, height: 5),
                                       opacity: 0.5,
                                       radius: 5)
    }
    
    // MARK: - Navigation
    func showQueueInfoVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QueueInfoViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
