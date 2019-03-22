//
//  AddBigGulpVC.swift
//  Gulpz
//
//  Created by Jett on 2/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit
import AVFoundation


class AddBigGulpVC: UIViewController {
    var confirmSound = AVAudioPlayer()

    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var bigGulpLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var currentAmount: Double = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        UIFormatter.buttonShadow(minusButton)
        UIFormatter.buttonShadow(plusButton)
        
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))
        
        let mySound = Bundle.main.path(forResource: "confirm", ofType: "wav")
        do {
            confirmSound = try AVAudioPlayer(contentsOf: URL (fileURLWithPath: mySound!))
            confirmSound.prepareToPlay()
        } catch {
            print(error)
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    
    }
    
    func setupView() {
        updateText()
        
        plusButton.addTarget(self, action: #selector(onPlusPressed), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(onMinusPressed), for: .touchUpInside)
    }
    
    @objc func onPlusPressed() {
        currentAmount += 1
        updateText()
    }
    
    @objc func onMinusPressed() {
        if currentAmount == 0 { return }
        currentAmount -= 1
        updateText()
    }
    
    func updateText() {
        numberLabel.text = String(currentAmount.format())
        let plural = currentAmount >= 2 ? "s" : ""
        bigGulpLabel.text = "big gulp\(plural)"
    }
    
    @IBAction func addBigGulpSound(_ sender: Any) {
        if (confirmSound.isPlaying) {
            confirmSound.stop()
        } else {
            confirmSound.play()
        }
        
        Setting.currentAmount += currentAmount * Setting.bigGulp
        navigationController?.popViewController(animated: true)
    }

}
