//
//  WelcomeLogoView.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 18.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class WelcomeLogoView: UIView {

    @IBOutlet private var view: UIView!
    
    @IBOutlet private var labels: [UILabel]!
    
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
        
        view = load(nibNamed: "WelcomeLogoView")
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        
    }
    
    var locations: Array<CGPoint> {
        guard let labels = self.labels else { return [] }
        return labels.map { label in
            return label.frame.origin
        }
    }

}
