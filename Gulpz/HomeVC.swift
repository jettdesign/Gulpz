//
//  HomeVC.swift
//  Gulpz
//
//  Created by Jett on 1/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    static func create() -> HomeVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    }
    @IBOutlet weak var progressAnimationDark: ActivityProgressGaugeView!
    @IBOutlet weak var bigGulpbutton: UIButton!
    @IBOutlet weak var smallGulpbutton: UIButton!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var greeting: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDateTime()
        getSingle()
        UIFormatter.buttonShadow(bigGulpbutton)
        UIFormatter.buttonShadow(smallGulpbutton)

        let lastOpenDate = Date(timeIntervalSince1970: Setting.lastOpen)
        Setting.lastOpen = Date().timeIntervalSince1970
        if lastOpenDate.isToday == false {
            Setting.currentAmount = 0
        }

        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))

            greeting.text = "Hi \(Setting.name ?? ""), you drank"
    }
    
   
    
    var progress = 0.0
    var displayLink: CADisplayLink!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        

        if let unit = Setting.unit {
            let dailyGoal = Setting.dailyGoal.format()
            let goal = "\(dailyGoal) \(unit.rawValue)"
            
            goalLabel.text = "\(Setting.currentAmount.format())/\(goal)"
        }
    }
    

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .common)
    }

    var step: Double {
        if Setting.unit == .oz {
            return 0.25
        } else {
            return 5
        }
    }

    @objc func update() {
        if Setting.currentAmount == 0 {
            displayLink.invalidate()
            return
        }

        if progress >= Double(Setting.currentAmount) {
            displayLink.invalidate()
        }
        progress += step
        progressAnimationDark.progress = CGFloat(progress) / CGFloat(Setting.dailyGoal)
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd,yyy"
        let str = formatter.string(from: Date())
        todayDate.text = str
    }
    
    func getSingle(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        print("\(year):\(month):\(day):")
        
    }

    @IBAction func bigGulpMade(_ sender: Any) {
        
    }
   
    
    @IBAction func smallGulpMade(_ sender: Any) {
    }
    
    
}

