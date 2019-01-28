//
//  QueueInfoViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/19/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit
import FirebaseAuth

class QueueInfoViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var peopleAheadLabel: UILabel!
    @IBOutlet weak var peopleBehindLabel: UILabel!
    @IBOutlet weak var bumpUpQueueButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var databaseService = DatabaseService()
    let initialQueueCapasity = 174100
    
    // MARK: - @IBAction
    @IBAction func bumpUpQueue(_ sender: UIButton) {
        //TODO: Bump up the queue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fillName()
        fillQueueInfo()
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
    
    func fillName() {
        let firstName = UserDefaults.standard.object(forKey: UserDefaultKeys.firstName) as? String
        firstNameLabel.text = "You're on the list, \(firstName ?? "-")!"
    }
    
    func fillQueueInfo() {
        activityIndicator.startAnimating()
        guard let userId = databaseService.userIdentifier else {
            self.activityIndicator.stopAnimating()
            self.showAlert(message: "Couldn't fetch user id")
            return
        }
        
        self.databaseService.fetchUser(for: userId) { user, error in
            guard let currentUser = user else {
                self.activityIndicator.stopAnimating()
                self.showAlert(message: error?.localizedDescription ?? "Couldn't fetch current user")
                return
            }
            
            self.databaseService.fetchUsersSortedByDate { users, error in
                guard let users = users else {
                    self.activityIndicator.stopAnimating()
                    self.showAlert(message: error?.localizedDescription ?? "Couldn't fetch users info")
                    return
                }

                self.activityIndicator.stopAnimating()
                if let currentUserIndex = users.index(of: currentUser) {
                    self.peopleAheadLabel.text = "\(self.initialQueueCapasity + currentUserIndex)"
                    self.peopleBehindLabel.text = "\(users.count - currentUserIndex - 1)"
                }
            }
            
        }
    }
}

//MARK: - API Communication methods
extension QueueInfoViewController {
    
}
