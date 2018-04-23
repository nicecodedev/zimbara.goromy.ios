//
//  UIViewController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 22.03.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func from(storyboard: String, withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func enableBlur() {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectView.tag = 7
        effectView.frame = view.bounds
        effectView.layer.opacity = 0.0
        view.addSubview(effectView)
        
        UIView.animate(withDuration: 0.25) {
            effectView.layer.opacity = 1.0
        }
    }
    
    private var blurView: UIVisualEffectView? {
        return view.subviews.first { $0.tag == 7 } as? UIVisualEffectView
    }
    
    func disableBlur() {
        UIView.animate(withDuration: 0.25, animations: {
            self.blurView?.layer.opacity = 0.0
        }, completion: { _ in
            self.blurView?.removeFromSuperview()
        })
    }
    
}
