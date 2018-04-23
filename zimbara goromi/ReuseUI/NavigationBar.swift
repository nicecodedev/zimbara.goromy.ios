//
//  NavigationBar.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
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
        
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        
        let color = RGB_A(113, 76, 190, ALPHA: 1)
        
        self.tintColor = color
        self.barTintColor = color
        self.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)
        ]
        
    }
    
    func applyLightStyle() {
        
        let color = UIColor.white
        self.tintColor = color
        self.barTintColor = color
        self.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)
        ]
        
    }

}
