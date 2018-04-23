//
//  GradientButton.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 04.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class GradientButton: UIButton {

    @IBInspectable var startColor: UIColor!
    @IBInspectable var startPoint: CGPoint = .zero
    @IBInspectable var startLocation: CGFloat = 0.0
    
    @IBInspectable var secondColor: UIColor!
    @IBInspectable var secondLocation: CGFloat = 0.0
    
    @IBInspectable var thirdColor: UIColor!
    @IBInspectable var thirdLocation: CGFloat = 0.0
    
    @IBInspectable var endColor: UIColor!
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 1, y: 1)
    @IBInspectable var endLocation: CGFloat = 1.0
    
    @IBInspectable var fillColor: UIColor!
    
    @IBInspectable var gradientText: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    private var gradientView: GradientView!
    
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
//        clipsToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            
            let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            borderPath.addClip()
            
            let colors = [startColor, secondColor, thirdColor, endColor]
            let locations = [startLocation, secondLocation, thirdLocation, endLocation]
//            let points = [startPoint, secondPoint, thirdPoint, endPoint]
            
            var gradientColors: Array<CGColor> = []
            var gradientLocations: Array<CGFloat> = []
//            var gradientPoints: Array<CGPoint> = []
            
            let data = zip(colors, locations)
            
            for (color, location) in data {
                if let color = color {
                    gradientColors.append(color.cgColor)
                    gradientLocations.append(location)
//                    gradientPoints.append(point)
                }
            }
            
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                      colors: gradientColors as CFArray,
                                      locations: gradientLocations)!
            
            let transformedStartPoint = CGPoint(x: startPoint.x * rect.width, y: startPoint.y * rect.height)
            let transformedEndPoint = CGPoint(x: endPoint.x * rect.width, y: endPoint.y * rect.height)
            
            context.drawLinearGradient(gradient,
                                       start: transformedStartPoint,
                                       end: transformedEndPoint,
                                       options: [])
            
            if let fillColor = self.fillColor {
                let fillRect = rect.insetBy(dx: 1, dy: 1)
                let path = UIBezierPath(roundedRect: fillRect, cornerRadius: cornerRadius > 0 ? cornerRadius - 1 : 0)
                fillColor.setFill()
                path.fill()
            }
            
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientText {
            if gradientView == nil {
                gradientView = GradientView(frame: bounds, withColors: [startColor, endColor], from: startPoint, to: endPoint, locations: [startLocation, endLocation])
                gradientView.isUserInteractionEnabled = false
                addSubview(gradientView)
            }

            gradientView.frame = bounds
            gradientView.mask = titleLabel
        }
//        } else {
//            gradientView?.removeFromSuperview()
//            addSubview(titleLabel!)
//            titleLabel?.setNeedsDisplay()
////            titleLabel?.textColor = UIColor.white
//        }
        
    }

}
