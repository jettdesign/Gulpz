//
//  DrinkAmountVC.swift
//  Gulpz
//
//  Created by Jett on 1/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class DrinkAmountVC: UIViewController, UITextFieldDelegate {
    var isFromSetting = false

    static func create() -> DrinkAmountVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkAmountVC") as! DrinkAmountVC
    }

    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var keyboardCS: NSLayoutConstraint!
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        goalTextField.resignFirstResponder()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Blue Gradient
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))

        // EventListeners keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupView () {
        UIFormatter.formatTextField(goalTextField)
        UIFormatter.formatNextButton(nextButton)
        goalTextField.keyboardType = .decimalPad
        goalTextField.returnKeyType = .done
        goalTextField.delegate = self
        nextButton.isEnabled = false

        if let unit = Setting.unit {
            let amount = "\(unit.getDailyGoal().format()) \(unit.rawValue)"
            let descriptionContent = "Studies found that drinking \(amount) of water a day can boost your mood and immune system."
            descriptionLabel.text = descriptionContent
        }



        if let amount = goalTextField.text, let value = Double(amount) {
            nextButton.isEnabled = value > 0

            if Setting.dailyGoal > 0 {
                nextButton.isEnabled = true
                goalTextField.text = "\(Setting.dailyGoal.format())"
            }


            if isFromSetting {
                nextButton.setTitle("Save", for: .normal)
            }
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isFromSetting {
            navigationController?.popViewController(animated: true)
            return false
        } else {
            return true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let text = goalTextField.text, let value = Double(text) {
            Setting.dailyGoal = value
            Setting.firstRun = false
        }
    }


    // Avoid keyboard obscuring the textfield
    @objc func keyboardWillChange(notification: Notification) {
        print("\(notification.name.rawValue)")
        guard let keyboardFrame =  notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else { return }

        let screenHeight: CGFloat = UIScreen.main.bounds.height

        UIView.animate(withDuration: 0.35, animations: {
            if keyboardFrame.origin.y == screenHeight {
                self.keyboardCS.constant = -110
            } else {
                self.keyboardCS.constant = 0
            }
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func finishOnboarding(_ sender: Any) {
        if let text = goalTextField.text, let value = Double(text) {

            Setting.dailyGoal = value

            if isFromSetting {
                navigationController?.popViewController(animated: true)
            } else {
                let controller = DrinkAmountVC.create()
                navigationController?.pushViewController(controller, animated: true)
            }
        }

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goalTextField.resignFirstResponder()
        return true
    }
}


