//
//  ContentNavigationController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ContentNavigationController: UINavigationController {
    
    lazy var contentTapRecognizer: UITapGestureRecognizer = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapRecognizer)
        return tapRecognizer
    }()
    
    @objc private func viewTapped() {
        MainMenuContainerController.shared?.hideMenu()
    }

}
