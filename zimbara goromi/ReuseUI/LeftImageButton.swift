//
//  LeftImageButton.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class LeftImageButton: UIButton {
    
    private let margin: CGFloat = 15
    
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
        imageView?.contentMode = .scaleAspectFit
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWidth: CGFloat = 25
        let imageHeight: CGFloat = 25
        let imageX = margin
        let imageY: CGFloat = (frame.height - imageHeight) / 2
        let imageRect = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        imageView?.frame = imageRect
        
        let titleX = margin * 2 + imageWidth
        let titleY: CGFloat = 0.0
        let titleWidth = frame.width - margin * 3
        let titleHeight = frame.height
        let titleRect = CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
        titleLabel?.frame = titleRect
    }

}
