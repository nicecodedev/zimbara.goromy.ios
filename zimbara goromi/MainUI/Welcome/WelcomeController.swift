//
//  WelcomeController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 22.03.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    @IBOutlet weak var gridView: SymbolsGridView!
    @IBOutlet weak var logoView: WelcomeLogoView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: iWelcomePresenter = WelcomePresenter()
    var animationsFinished = false
    var needOpenApp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView?.layer.opacity = 0.0
        logoImageView?.layer.opacity = 0.0
        
        presenter.view = self
        presenter.checkSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gridView?.runAnimation { [weak self] in
            self?.animateSymbolsMoving()
        }
        
    }
    
    func animateSymbolsMoving() {
        
        let startPoint = CGPoint(x: self.logoView.frame.origin.x - self.gridView.frame.origin.x, y: self.logoView.frame.origin.y - self.gridView.frame.origin.y)
        self.gridView?.moveImages(to: self.logoView.locations, withStart: startPoint) {
            
            self.logoImageView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.logoImageView?.transform = CGAffineTransform.identity
                self.gridView.layer.opacity = 0.0
                self.logoView.layer.opacity = 1.0
                self.logoImageView.layer.opacity = 1.0
            }, completion: { _ in
                
                self.animationsFinished = true
                
                if self.needOpenApp {
                    self.showOpenAppAnimation()
                }
                
            })
            
        }
        
    }
    
    func showOpenAppAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveLinear, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.logoImageView.layer.opacity = 0.0
            self.logoView.layer.opacity = 0.0
        }, completion: { _ in
            
            UIApplication.shared.changeController(to: MainMenuContainerController.self)
            
        })
        
    }
    
}

protocol WelcomeView: class {
    func showConnectionLost()
    func setNeedsOpenApp()
}

extension WelcomeController: WelcomeView {
    
    func showConnectionLost() {
        
    }
    
    func setNeedsOpenApp() {
        needOpenApp = true
        if animationsFinished {
            showOpenAppAnimation()
        }
    }
}
