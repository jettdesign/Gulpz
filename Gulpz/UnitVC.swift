//
//  UnitVC.swift
//  Gulpz
//
//  Created by Jett on 3/7/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class UnitVC: UIViewController, UITextFieldDelegate {

    var isFromSetting = false
    static func create() -> UnitVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UnitVC") as! UnitVC
    }
    
    @IBOutlet weak var mlButton: UIButton!
    @IBOutlet weak var ozButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var unit: Unit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIFormatter.buttonShadow(mlButton)
        UIFormatter.buttonShadow(ozButton)
        setupView()
        
        
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))

        mlButton.addTarget(self, action: #selector(onMlSelected), for: .touchUpInside)
        ozButton.addTarget(self, action: #selector(onOzSelected), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    func setupView() {
        formatUnitButton(mlButton, selected: false)
        formatUnitButton(ozButton, selected: false)
        UIFormatter.formatNextButton(nextButton)
        nextButton.isEnabled = false
        
        if let selectedUnit = Setting.unit {
            nextButton.isEnabled = true
            if selectedUnit == .ml {
                formatUnitButton(mlButton, selected: true)
            }
            
            if selectedUnit == .oz {
                formatUnitButton(ozButton, selected: true)
            }
        }
        
        if isFromSetting {
            nextButton.setTitle("Save", for: .normal)
        }
    }
    
    @objc func onMlSelected() {
        formatUnitButton(mlButton, selected: true)
        formatUnitButton(ozButton, selected: false)
        nextButton.isEnabled = true
        unit = Unit.ml
    }
    
    func formatUnitButton(_ button: UIButton, selected: Bool) {
        if selected {
            button.backgroundColor = UIColor.themeColor
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = UIColor.white
            button.setTitleColor(.themeColor, for: .normal)
            button.layer.borderColor = UIColor.themeColor.cgColor
            button.layer.borderWidth = 0.5
        }
    }
    
    @objc func onOzSelected() {
        formatUnitButton(mlButton, selected: false)
        formatUnitButton(ozButton, selected: true)
        nextButton.isEnabled = true
        unit = Unit.oz
    }
    
    @objc func goNext() {
        Setting.unit = unit
        if isFromSetting {
            navigationController?.popViewController(animated: true)
        } else {
            let controller = BiggulpVC.create()
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    

}
