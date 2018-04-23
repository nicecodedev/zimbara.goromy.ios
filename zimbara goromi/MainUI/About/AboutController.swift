//
//  AboutController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class AboutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openMenu(_ sender: Any) {
        MainMenuContainerController.shared?.showMenu()
    }
    
}
