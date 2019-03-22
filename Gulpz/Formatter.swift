//
//  UIFormatter.swift
//  Gulpz
//
//  Created by Jett on 2/21/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

struct UIFormatter {
    static func formatTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 37.5
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
    }
    
    static func formatNextButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackground(color: UIColor.lightGray.withAlphaComponent(0.8), forState: .disabled)
        button.setBackground(color: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), forState: .normal)
    }
    
    static func buttonShadow(_ button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.2
    }
    


}

extension UIButton {
    func setBackground(color: UIColor, forState: UIControl.State) {
        let colorImage = imageFromColor(color: color)
        setBackgroundImage(colorImage, for: forState)
    }
    
    private func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension Double {
    func format() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 { return
            String(Int(self))
        }
        return String(self)
    }

    mutating func roundToOne() {
        self.round(.toNearestOrAwayFromZero)
    }
}

struct Formatter {
    static func roundNumber(_ number: Double) -> String {
        var newNumber = number
        newNumber.round(.toNearestOrAwayFromZero)
        return String(newNumber)
    }
    
}
