//
//  ActivityProgressGaugeView.swift
//  Gulpz
//
//  Created by Jett on 2/18/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class ActivityProgressGaugeView: UIView {

    private var _progress: CGFloat = 0.0
    
    var progress: CGFloat {
        
        set (newProgress) {
            if newProgress > 1.0 {
                _progress = 1.0
            } else if newProgress < 0.0 {
                _progress = 0.0
            } else {
                _progress = newProgress
            }
            
            setNeedsDisplay()
        }
        
        
        get {
            return _progress
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        //WaterRing.drawProgressAnimationDark()
        
        WaterRing.drawProgressAnimationDark(frame: bounds, resizing: .aspectFit, progress: progress)
        
        
    }
    
    
}
