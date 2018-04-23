//
//  MoreButton.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class MoreButton: UIControl {

    @IBOutlet private var view: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    
    @IBInspectable var title: String! {
        didSet { titleLabel?.text = title }
    }
    @IBInspectable var info: String! {
        didSet { infoLabel?.text = info }
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
        
        view = load(nibNamed: "MoreButton")
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
        infoLabel?.text = info
        
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateTap()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateDismiss()
        if touches.first?.location(in: self).isIn(rect: bounds) == true {
            sendActions(for: .touchUpInside)
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        animateTap()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateDismiss()
    }

}
