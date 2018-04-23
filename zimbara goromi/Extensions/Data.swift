//
//  Data.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 23.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    
    func asImage(scaled scale: CGFloat = 1.0) -> UIImage? {
        return UIImage(data: self, scale: scale)
    }
    
}
