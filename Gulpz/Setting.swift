//
//  Setting.swift
//  Gulpz
//
//  Created by Jett on 2/21/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit


struct Setting {
    static var firstRun: Bool {
        get {
            if let value = UserDefaults.standard.value(forKey: "firstRun") as? Bool {
                return value
            }
            
            return true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "firstRun")
        }
    }
    
    static var name: String? {
        get {
            return UserDefaults.standard.string(forKey: "name") 
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    
    static var bigGulp: Double {
        get {
            return UserDefaults.standard.double(forKey: "bigGulp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bigGulp")
        }
    }
    
    static var smallGulp: Double {
        get {
            return UserDefaults.standard.double(forKey: "smallGulp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "smallGulp")
        }
    }
    
    static var dailyGoal: Double {
        get {
            return UserDefaults.standard.double(forKey: "dailyGoal")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "dailyGoal")
        }
    }

    static var lastOpen: Double {
        get {
            return UserDefaults.standard.double(forKey: "lastOpen")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lastOpen")
        }
    }
    
    static var currentAmount: Double {
        get {
            return UserDefaults.standard.double(forKey: "currentAmount")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentAmount")
        }
    }
    
    static var unit: Unit? {
        get {
            if let savedUnit = UserDefaults.standard.string(forKey: "unit"),
                let _unit = Unit(rawValue: savedUnit) {
                return _unit
            }
            return Unit.ml
        }
        set {
            guard let value = newValue else {
                UserDefaults.standard.removeObject(forKey: "unit")
                return
            }
            UserDefaults.standard.set(value.rawValue, forKey: "unit")
        }
    }
}

enum Unit: String {
    case ml, oz

    func getBigGulpAmount() -> Double {
        if self == Unit.ml { return 112.0 }
        return 4.0
    }
    
    func getSmallGulpAmount() -> Double {
        if self == Unit.ml { return 50.0 }
        return 2.0
    }
    
    func getDailyGoal() -> Double {
        if self == Unit.ml { return 2000.0 }
        return 68.0
    }
}


extension UIColor {
    static let themeColor = UIColor.init(red: 0, green: 121/255, blue: 1, alpha: 1)
}

extension Date {
    var isToday: Bool { return Calendar.current.isDateInToday(self) }
}
