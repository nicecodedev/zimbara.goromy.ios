//
//  GradientView.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 04.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    private var gradientLayer: CAGradientLayer!
    
    convenience init(frame: CGRect, withColors colors: Array<UIColor>, from startPoint: CGPoint = CGPoint.zero, to endPoint: CGPoint = CGPoint(x: 1, y: 1), locations: Array<CGFloat> = [0.0, 1.0]) {
        self.init(frame: frame)
        gradientLayer = addBackgroundGradientLayer(withColors: colors, from: startPoint, to: endPoint, locations: locations)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = frame
    }

}
