//
//  ProfileItemControl.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 17.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class ProfileItemControl: UIControl {

    @IBOutlet private var view: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    @IBInspectable var title: String? {
        didSet { titleLabel?.text = title }
    }
    @IBInspectable var value: String? {
        didSet { valueLabel?.text = value }
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
        backgroundColor = .clear
        
        view = load(nibNamed: "ProfileItemControl")
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        
        titleLabel?.text = title
        valueLabel?.text = value
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.location(in: self).isIn(rect: bounds) == true {
            sendActions(for: .touchUpInside)
        }
    }

}
