//
//  QueueInfoViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class QueueInfoViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var peopleAheadLabel: UILabel!
    @IBOutlet weak var peopleBehindLabel: UILabel!
    @IBOutlet weak var bumpUpQueueButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func bumpUpQueue(_ sender: UIButton) {
        //TODO: Bump up the queue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        bumpUpQueueButton.roundCorners(radius: 3)
        bumpUpQueueButton.layer.masksToBounds = false
        bumpUpQueueButton.layer.addShadow(color: #colorLiteral(red: 0.3089829385, green: 0.6156063676, blue: 0.9604739547, alpha: 1),
                                    offset: CGSize(width: 5, height: 5),
                                    opacity: 0.5,
                                    radius: 5)
    }
}
