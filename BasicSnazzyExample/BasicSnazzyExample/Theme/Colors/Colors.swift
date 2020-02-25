//
//  Colors.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
import Snazzy

struct Colors {
    // This color uses a color asset located in Assets.xcassets
    // this color will dynamically change for dark mode (ios 13 only)
    let mainText = ThemeColor(UIColor(named: "MainText")!, name: "Main Text")
    // this is just simple color that won't change 
    let actionBg = ThemeColor(UIColor.orange, name: "Action")
}
