//
//  UIApplication.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    func changeController(to identified: iIdentified.Type) {
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = UIViewController.from(identified)
        })
    }
    
}
