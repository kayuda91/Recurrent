//
//  PasscodeViewController.swift
//  Recurrent
//
//  Created by Stepan Kukharskyi on 1/16/19.
//  Copyright © 2019 Steve Harski. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController {

    @IBOutlet weak var createPasscodeTitle: UILabel!
    @IBOutlet weak var filledPasscodeStackview: UIStackView!
    
    var passcode = [Int]() {
        didSet {
            updateFilledPasscodeCircles()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        passcode.removeAll()
    }
    
    // MARK: - @IBAction
    @IBAction func navigateBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectNumber(_ sender: UIButton) {
        if sender.tag == 10 && passcode.count > 0 {
            passcode.removeLast()
        } else if sender.tag != 10 && passcode.count < 4 {
            passcode.append(sender.tag)
        }
        
        if passcode.count == 4 {
            savePasscode()
            navigateToPersonalDetailsScreen()
        }
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        configurePasscodeTitle()
        configureFilledPasscodeCircles()
    }
    
    func configurePasscodeTitle() {
        createPasscodeTitle.text = "Create a passcode \nfor your Recurrent account"
    }
    
    func configureFilledPasscodeCircles() {
        filledPasscodeStackview.subviews.forEach { view in
            view.roundCorners()
        }
    }
    
    func updateFilledPasscodeCircles() {
        for i in filledPasscodeStackview.subviews.indices {
            filledPasscodeStackview.subviews[i].backgroundColor = i < passcode.count ? #colorLiteral(red: 0.2509803922, green: 0.5333333333, blue: 0.9490196078, alpha: 1) : #colorLiteral(red: 0.7843137255, green: 0.8549019608, blue: 0.968627451, alpha: 1)
        }
    }
    
    func savePasscode() {
        UserDefaults.standard.set(passcode,
                                  forKey: UserDefaultKeys.passcode)
    }
    
    // MARK: - Navigation
    func navigateToPersonalDetailsScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalDetailsViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
