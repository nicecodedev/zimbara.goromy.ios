//
//  SwitchButton.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchButton: UIControl {

    @IBOutlet private var view: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var `switch`: Switch!
    
    @IBInspectable var title: String! {
        didSet { titleLabel?.text = title }
    }
    @IBInspectable var isOn: Bool = false {
        didSet { `switch`?.isOn = isOn }
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
        
        view = load(nibNamed: "SwitchButton")
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        
        contentView?.layer.cornerRadius = 4
        contentView?.clipsToBounds = true
        contentView?.layer.borderColor = RGB_A(0xE5, 0xEC, 0xED, ALPHA: 1).cgColor
        contentView?.layer.borderWidth = 1
        
        shadowView?.layer.shadowColor = RGB_A(0xE5, 0xEC, 0xED, ALPHA: 1).cgColor
        shadowView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView?.layer.shadowRadius = 2.0
        shadowView?.layer.shadowOpacity = 1.0
        
        titleLabel?.text = title
        `switch`?.isOn = isOn
        
    }

}
