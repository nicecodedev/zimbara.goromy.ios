//
//  IconTextField.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class IconTextField: UITextField {

    @IBInspectable var iconImage: UIImage! {
        didSet {
            iconImageView?.image = iconImage
        }
    }
    
    @IBInspectable var borderColor: UIColor! {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius ?? 0.0
        }
    }
    
    private var iconImageView: UIImageView!
    
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
        borderStyle = .none
        layer.cornerRadius = cornerRadius ?? 0.0
        layer.borderWidth = 1
        layer.borderColor = borderColor?.cgColor
        iconImageView = UIImageView(image: iconImage)
        iconImageView.contentMode = .scaleAspectFit
        leftView = iconImageView
        leftViewMode = .always
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = frame.height
        let iconViewSize = CGSize(width: 15, height: height)
        let iconViewOrigin = CGPoint(x: 15, y: 0)
        iconImageView?.frame = CGRect(origin: iconViewOrigin, size: iconViewSize)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let origin = CGPoint(x: 40, y: 0)
        let size = CGSize(width: bounds.width - 50, height: bounds.height)
        let rect = CGRect(origin: origin, size: size)
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let origin = CGPoint(x: 40, y: 0)
        let size = CGSize(width: bounds.width - 50, height: bounds.height)
        let rect = CGRect(origin: origin, size: size)
        return rect
    }

}
