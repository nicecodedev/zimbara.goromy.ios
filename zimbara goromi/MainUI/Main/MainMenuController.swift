//
//  MainMenuController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    
    private var gradientBackgroundLayer: CAGradientLayer!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var signInButton: LeftImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientBackgroundLayer = view.addBackgroundGradientLayer(withColors: [RGB_A(135, 23, 194, ALPHA: 1), RGB_A(55, 217, 180, ALPHA: 1)])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        userView?.addGestureRecognizer(tapRecognizer)
        userView?.isUserInteractionEnabled = true
        
        signInButton?.isHidden = true
        signInButton?.isEnabled = false
    }
    
    @objc private func profileTapped() {
        MainMenuContainerController.shared?.setContent(identified: ProfileNavigationController.self)
    }
    
    @IBAction func openSignIn(_ sender: Any) {
        
    }
    
    @IBAction func openBooks(_ sender: Any) {
        MainMenuContainerController.shared?.setContent(identified: BooksNavigationController.self)
    }
    
    @IBAction func openAbout(_ sender: Any) {
        MainMenuContainerController.shared?.setContent(identified: AboutNavigationController.self)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        MainMenuContainerController.shared?.setContent(identified: SettingsNavigationController.self)
    }
    
    @IBAction func openSupport(_ sender: Any) {
        MainMenuContainerController.shared?.setContent(identified: SupportNavigationController.self)
    }

}
