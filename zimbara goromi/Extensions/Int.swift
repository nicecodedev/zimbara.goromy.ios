//
//  Int.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation

extension Int {
    
    func times(_ action: () -> ()) {
        guard self > 0 else { return }
        for _ in 0..<self { action() }
    }
    
}
