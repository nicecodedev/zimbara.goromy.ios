//
//  ColoredButton.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class ColoredButton: UIButton {
    
    @IBInspectable var icon: UIImage! {
        didSet {
            setImage(icon?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
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
        setTitleColor(tintColor, for: .normal)
    }

}
