//
//  ProfileLogoutController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 18.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ProfileLogoutController: UIViewController {
    
    private lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = self.view.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.insertSubview(blurView, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        blurView.frame = view.bounds
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
    }
    
    
}
