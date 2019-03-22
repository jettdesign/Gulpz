//
//  SettingVC.swift
//  Gulpz
//
//  Created by Jett on 3/8/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {

    @IBOutlet weak var unitOfMesurementLabel: UILabel!
    @IBOutlet weak var smallGulpLabel: UILabel!
    @IBOutlet weak var bigGulpLabel: UILabel!
    @IBOutlet weak var dailyGoalLabel: UILabel!
    
    var currentUnit = Setting.unit

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData() {
        guard let unit = Setting.unit?.rawValue else { return }
        unitOfMesurementLabel.text = unit
        
        var smallGulp = Setting.smallGulp
        var bigGulp = Setting.bigGulp
        var dailyGoal = Setting.dailyGoal
        
        if currentUnit?.rawValue != unit {
            if currentUnit == Unit.oz {
                smallGulp = ozToMl(number: smallGulp)
                bigGulp = ozToMl(number: bigGulp)
                dailyGoal = ozToMl(number: dailyGoal)
            } else {
                smallGulp = mlToOz(number: smallGulp)
                bigGulp = mlToOz(number: bigGulp)
                dailyGoal = mlToOz(number: dailyGoal)
            }

            Setting.smallGulp = smallGulp
            Setting.bigGulp = bigGulp
            Setting.dailyGoal = dailyGoal
            currentUnit = Setting.unit
        }
        
        smallGulpLabel.text = "\(smallGulp.format()) \(unit)"
        bigGulpLabel.text = "\(bigGulp.format()) \(unit)"
        dailyGoalLabel.text = "\(dailyGoal.format()) \(unit)"
    }
    
    func ozToMl(number: Double) -> Double {
        var newNumber = Double(number) * 29.5735
        newNumber.roundToOne()
        return newNumber
    }
    
    func mlToOz(number: Double) -> Double {
        var newNumber = Double(number) / 29.5735
        newNumber.roundToOne()
        return newNumber
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let browser = WebBrowser.create()
            browser.url = "https://jettdesign.us"
            browser.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(browser, animated: true)
            break
            
        case (1, 0):
            let controller = UnitVC.create()
            controller.hidesBottomBarWhenPushed = true
            controller.isFromSetting = true
            navigationController?.pushViewController(controller, animated: true)
            break
            
        case (2, 0):
            let controller = SmallGulpVC.create()
            controller.hidesBottomBarWhenPushed = true
            controller.isFromSetting = true
            navigationController?.pushViewController(controller, animated: true)
            break
            
        case (2, 1):
            let controller = BiggulpVC.create()
            controller.hidesBottomBarWhenPushed = true
            controller.isFromSetting = true
            navigationController?.pushViewController(controller, animated: true)
            break
            
        case (2, 2):
            let controller = DrinkAmountVC.create()
            controller.hidesBottomBarWhenPushed = true
            controller.isFromSetting = true
            navigationController?.pushViewController(controller, animated: true)
            break
            
        default:
            break
        }
    }

}
