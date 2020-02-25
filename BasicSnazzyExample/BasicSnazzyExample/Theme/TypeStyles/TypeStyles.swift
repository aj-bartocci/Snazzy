//
//  TypeStyles.swift
//  BasicSnazzyExample
//
//  Created by AJ Bartocci on 2/24/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit
import Snazzy

struct TypeStyles {
    let header = TypeStyle(name: "Header", font: {
        return Theme.current.font.robotoBold.withSize(40)
    })
    let body = TypeStyle(name: "Body", font: {
        return Theme.current.font.playfairRegular.withSize(20)
    })
    let actionButton = TypeStyle(name: "Action Button", font: {
        return Theme.current.font.robotoBold.withSize(20)
    })
}
