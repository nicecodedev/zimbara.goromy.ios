//
//  Macro.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

func RGB_A(_ RED: CGFloat, _ GREEN: CGFloat, _ BLUE: CGFloat, ALPHA: CGFloat) -> UIColor {
    let r = RED / 255
    let g = GREEN / 255
    let b = BLUE / 255
    let color = UIColor(red: r, green: g, blue: b, alpha: ALPHA)
    return color
}
