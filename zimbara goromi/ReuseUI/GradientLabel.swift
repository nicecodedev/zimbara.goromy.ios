//
//  GradientLabel.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class GradientLabel: UIView {
    
    @IBInspectable var startColor: UIColor!
    @IBInspectable var startPoint: CGPoint = .zero
    @IBInspectable var startLocation: CGFloat = 0.0
    
    @IBInspectable var endColor: UIColor!
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1)
    @IBInspectable var endLocation: CGFloat = 1.0
    
    @IBInspectable var text: String!
    @IBInspectable var textColor: UIColor!
    @IBInspectable var fontSize: CGFloat = 14.0
    @IBInspectable var numberOfLines: Int = 0
    @IBInspectable var lineSpacing: CGFloat = 0.0
    @IBInspectable var kern: CGFloat = 0.0
    
    private var gradientView: GradientView!
    private var label: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientView == nil {
            gradientView = GradientView(frame: bounds, withColors: [startColor, endColor], from: startPoint, to: endPoint, locations: [startLocation, endLocation])
            addSubview(gradientView)
        
            label = UILabel(frame: bounds)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = .center
            
            let attributedString = NSAttributedString(string: text, attributes: [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize, weight: .light),
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.kern: kern
            ])
            
            label.textAlignment = .center
            label.numberOfLines = numberOfLines
            
            label.attributedText = attributedString
            
            gradientView.addSubview(label)
        }
        
        gradientView.mask = label
            
        gradientView.frame = bounds
        label.frame = bounds
        
    }

}
