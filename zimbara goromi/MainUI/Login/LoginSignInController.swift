//
//  LoginSignInController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 05.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class LoginSignInController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    lazy var backgroundGradientView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.frame = self.view.bounds
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(backgroundGradientView, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        backgroundGradientView.frame = view.bounds
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }

}
