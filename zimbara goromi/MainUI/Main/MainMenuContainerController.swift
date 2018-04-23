//
//  MainMenuContainerController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class MainMenuContainerController: UIViewController {
    
    private static var _shared: MainMenuContainerController?
    static var shared: MainMenuContainerController? {
        return _shared
    }
    
    var menuController: MainMenuController!
    var contentNavigationController: ContentNavigationController!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let identified = contentNavigationController as? iIdentified, type(of: identified).identifier == ProfileNavigationController.identifier {
            return .lightContent
        }
        return menuOpened ? .lightContent : .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainMenuContainerController._shared = self
        
        menuController = UIViewController.from(MainMenuController.self)
        addChildViewController(menuController)
        view.addSubview(menuController.view)
        
        contentNavigationController = UIViewController.from(BooksNavigationController.self)
        addChildViewController(contentNavigationController)
        view.addSubview(contentNavigationController.view)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        menuController.view.frame = view.frame
//        contentNavigationController.view.frame = view.frame
    }
    
    func setContent(identified: iIdentified.Type) {
        
        let currentIdentifier: String = type(of: contentNavigationController as! iIdentified).identifier
        guard identified.identifier != currentIdentifier else {
            hideMenu()
            return
        }
        
        contentNavigationController.view.removeFromSuperview()
        contentNavigationController.removeFromParentViewController()
        contentNavigationController = UIViewController.from(identified)
        addChildViewController(contentNavigationController)
        view.addSubview(contentNavigationController.view)
        
        let heightDelta = view.frame.height * 0.02
        let translationX = view.frame.width * 0.75
        contentNavigationController?.view?.transform = CGAffineTransform(translationX: translationX, y: heightDelta).scaledBy(x: 0.85, y: 0.85)
        contentNavigationController?.view?.layer.cornerRadius = 8
        contentNavigationController.enableBlur()
        
        hideMenu()
    }
    
    private var menuOpened = false
    
    func showMenu() {
        menuOpened = true
        contentNavigationController?.contentTapRecognizer.isEnabled = true
        self.setNeedsStatusBarAppearanceUpdate()
        let heightDelta = view.frame.height * 0.02
        let translationX = view.frame.width * 0.75
        UIView.animate(withDuration: 0.25, animations: {
            self.contentNavigationController?.view?.transform = CGAffineTransform(translationX: translationX, y: heightDelta).scaledBy(x: 0.85, y: 0.85)
            self.contentNavigationController?.view?.layer.cornerRadius = 8
        })
        self.contentNavigationController?.enableBlur()
    }
    
    func hideMenu() {
        guard menuOpened else { return }
        menuOpened = false
        contentNavigationController?.contentTapRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.25, animations: {
            self.contentNavigationController?.view?.transform = CGAffineTransform.identity
            self.contentNavigationController?.view?.layer.cornerRadius = 0
        }, completion: { _ in
            self.setNeedsStatusBarAppearanceUpdate()
        })
        self.contentNavigationController?.disableBlur()
    }

}
