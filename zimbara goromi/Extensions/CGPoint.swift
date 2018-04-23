//
//  CGPoint.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func isIn(rect: CGRect) -> Bool {
        return self.x >= rect.origin.x && self.x <= rect.origin.x + rect.width && self.y >= rect.origin.y && self.y <= rect.origin.y + rect.height
    }
}
