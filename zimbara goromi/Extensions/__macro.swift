//
//  __macro.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 18.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation

func __enumerate(_ rows: Int, _ columns: Int, action: (_ row: Int, _ column: Int) -> Void) {
    guard rows > 0, columns > 0 else { return }
    for row in 0..<rows {
        for column in 0..<columns {
            action(row, column)
        }
    }
}
