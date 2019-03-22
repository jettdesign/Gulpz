//
//  BiggulpVC.swift
//  Gulpz
//
//  Created by Jett on 1/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class BiggulpVC: UIViewController, UITextFieldDelegate {
    var isFromSetting = false
    
    static func create() -> BiggulpVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BiggulpVC") as! BiggulpVC
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bigGulpTextField: UITextField!
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        bigGulpTextField.resignFirstResponder()
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var keyboardCS: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
         // Blue Gradient
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))
        
        //EventListeners keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setupView() {
        UIFormatter.formatTextField(bigGulpTextField)
        UIFormatter.formatNextButton(nextButton)
        bigGulpTextField.keyboardType = .decimalPad
        bigGulpTextField.returnKeyType = .done
        bigGulpTextField.delegate = self
        nextButton.isEnabled = false
        
        if let unit = Setting.unit {
            let amount = "\(unit.getBigGulpAmount().format()) \(unit.rawValue)"
            let descriptionContent = "(An avarage person’s \nbig gulp is about \(amount))"
            descriptionLabel.text = descriptionContent
        }

        
        if let amount = bigGulpTextField.text, let value = Double(amount) {
            nextButton.isEnabled = value > 0


        if Setting.bigGulp > 0 {
            nextButton.isEnabled = true
            bigGulpTextField.text = "\(Setting.bigGulp.format())"
        }

        if isFromSetting {
            nextButton.setTitle("Save", for: .normal)
        }
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
    
    
    @IBAction func goNextScreen(_ sender: Any) {
        if let text = bigGulpTextField.text, let value = Double(text) {
            Setting.bigGulp = value
            
            if isFromSetting {
                navigationController?.popViewController(animated: true)
            } else {
                let controller = SmallGulpVC.create()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if let value = Double(newText), value <= 0 {
            nextButton.isEnabled = false
        } else if newText.isEmpty {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bigGulpTextField.resignFirstResponder()
        return true
    }
}


