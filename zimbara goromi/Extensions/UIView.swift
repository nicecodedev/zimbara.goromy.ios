//
//  UIView.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func load(nibNamed name: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed(name, owner: self)?.first as! UIView
        return view
    }
    
    func animateTap() {
        let delta: CGFloat = 8
        let scale: CGFloat = (frame.width - delta) / frame.width
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func animateDismiss() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    @discardableResult func addBackgroundGradientLayer(withColors colors: Array<UIColor>, from startPoint: CGPoint = CGPoint.zero, to endPoint: CGPoint = CGPoint(x: 1, y: 1), locations: Array<CGFloat> = [0.0, 1.0]) -> CAGradientLayer {
        
        let gradientBackgroundLayer = CAGradientLayer()
        gradientBackgroundLayer.colors = colors.map { $0.cgColor }
        gradientBackgroundLayer.locations = locations as [NSNumber]
        gradientBackgroundLayer.startPoint = startPoint
        gradientBackgroundLayer.endPoint = endPoint
        gradientBackgroundLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientBackgroundLayer, at: 0)
        
        return gradientBackgroundLayer
    }
    
}
