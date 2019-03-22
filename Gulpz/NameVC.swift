//
//  NameVC.swift
//  Gulpz
//
//  Created by Jett on 1/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class NameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var keyboardCS: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        nameTextField.text = Setting.name
        
        // Blue Gradient
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))
        
       //EventListener for keyboards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    func setupView() {
        UIFormatter.formatTextField(nameTextField)
        nameTextField.returnKeyType = .done
        nameTextField.delegate = self
        UIFormatter.formatNextButton(nextButton)
        nextButton.isEnabled = Setting.name?.isEmpty == false
        
    }
    
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.35, animations: {
            self.keyboardCS.constant = 0
            self.view.layoutIfNeeded()
        })
    }

    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.35, animations: {
            self.keyboardCS.constant = -110
            self.view.layoutIfNeeded()
        })
    }

    
   @IBAction func goNextScreen(_ sender: Any) {
        Setting.name = nameTextField.text
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
        nameTextField.resignFirstResponder()
        return true
    }
}


