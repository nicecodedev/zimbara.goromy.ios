//
//  SignInFormView.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class SignInFormView: UIView {
    
    @IBOutlet var view: UIView!
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let radius: CGFloat = 9.0
            let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            UIColor.white.setFill()
            path.addClip()
            path.fill()
        }
    }

    private func loadUI() {
        view = load(nibNamed: "SignInFormView")
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        
        backgroundColor = .clear
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
    
    @IBAction private func signIn(_ sender: Any) {
        
    }
    
}

protocol SignInFormViewDelegate {
    func signIn(_ signInFormView: SignInFormView, withUsername username: String, andPassword password: String)
    func signInError(_ signInFormView: SignInFormView)
}
