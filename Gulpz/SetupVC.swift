//
//  SetupVC.swift
//  Gulpz
//
//  Created by Jett on 1/25/19.
//  Copyright © 2019 Jett. All rights reserved.
//

import UIKit

class SetupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.setGradientBackground(colorOne: UIColor(red:0.00, green:0.47, blue:1.00, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.25, blue:0.61, alpha:1.0))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
