//
//  Switch.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class Switch: UIControl {
    
    @IBInspectable var isOn: Bool = false {
        didSet { layoutSubviews() }
    }
    
    private static let inactiveColor = RGB_A(0xD9, 0xE0, 0xE1, ALPHA: 1)
    private static let activeColor = RGB_A(0x71, 0x4C, 0xBE, ALPHA: 1)
    
    private static let inactiveShadowColor = RGB_A(0x4C, 0x5D, 0x60, ALPHA: 0.38)
    private static let activeShadowColor = RGB_A(0x71, 0x4C, 0xBE, ALPHA: 0.69)
    
    private static let backgroundSize = CGSize(width: 40, height: 26)
    private static let pinSize = CGSize(width: 20, height: 20)
    
    private var backgroundOrigin: CGPoint {
        let x: CGFloat = (frame.width - Switch.backgroundSize.width) / 2
        let y: CGFloat = (frame.height - Switch.backgroundSize.height) / 2
        let point = CGPoint(x: x, y: y)
        return point
    }
    
    private var pinOffOrigin: CGPoint {
        let backgroundOrigin = self.backgroundOrigin
        let x: CGFloat = backgroundOrigin.x + 3
        let y: CGFloat = backgroundOrigin.y + 3
        let point = CGPoint(x: x, y: y)
        return point
    }
    
    private var pinOnOrigin: CGPoint {
        let backgroundOrigin = self.backgroundOrigin
        let x: CGFloat = backgroundOrigin.x + Switch.backgroundSize.width - 3 - Switch.pinSize.width
        let y: CGFloat = backgroundOrigin.y + Switch.backgroundSize.height - 3 - Switch.pinSize.height
        let point = CGPoint(x: x, y: y)
        return point
    }

    private var backgroundLayer: CALayer!
    private var pinLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadUI()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadUI()
    }
    
    private func loadUI() {
        
        backgroundColor = .clear
        
        if backgroundLayer == nil {
            backgroundLayer = CALayer()
            backgroundLayer.backgroundColor = UIColor.clear.cgColor
//            backgroundLayer.frame = CGRect(origin: backgroundOrigin, size: Switch.backgroundSize)
            layer.addSublayer(backgroundLayer)
            backgroundLayer.borderWidth = 1.0
//            backgroundLayer.borderColor = Switch.inactiveColor.cgColor
            backgroundLayer.cornerRadius = 13
        }
        
        if pinLayer == nil {
            pinLayer = CALayer()
//            pinLayer.backgroundColor = UIColor.white.cgColor
//            pinLayer.frame = CGRect(origin: isOn ? pinOnOrigin : pinOffOrigin, size: Switch.pinSize)
            layer.addSublayer(pinLayer)
            pinLayer.borderWidth = 1.0
//            pinLayer.borderColor = Switch.inactiveColor.cgColor
            pinLayer.cornerRadius = 10
            
//            pinLayer.shadowColor = Switch.inactiveShadowColor.cgColor
//            pinLayer.shadowOffset = CGSize(width: 1, height: 2)
            pinLayer.shadowRadius = 1
            pinLayer.shadowOpacity = 1.0
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundLayer?.frame = CGRect(origin: backgroundOrigin, size: Switch.backgroundSize)
        backgroundLayer?.borderColor = isOn ? Switch.activeColor.cgColor : Switch.inactiveColor.cgColor
        
        pinLayer?.frame = CGRect(origin: isOn ? pinOnOrigin : pinOffOrigin, size: Switch.pinSize)
        pinLayer?.shadowColor = isOn ? Switch.activeShadowColor.cgColor : Switch.inactiveShadowColor.cgColor
        pinLayer?.backgroundColor = isOn ? Switch.activeColor.cgColor : UIColor.white.cgColor
        pinLayer?.borderColor = isOn ? Switch.activeColor.cgColor : Switch.inactiveColor.cgColor
        pinLayer.shadowOffset = CGSize(width: isOn ? -2 : 2, height: 1)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.location(in: self).isIn(rect: bounds) == true {
            sendActions(for: .valueChanged)
            isOn = !isOn
        }
    }
    
}
