//
//  SupportController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class SupportController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func showMenu(_ sender: Any) {
        MainMenuContainerController.shared?.showMenu()
    }
    
    @IBAction func openFaq(_ sender: Any) {
        print("faq")
        performSegue(withIdentifier: "faq", sender: self)
    }
    
    @IBAction func openErrorReport(_ sender: Any) {
        print("error report")
        performSegue(withIdentifier: "error", sender: self)
    }
    
    @IBAction func openZg(_ sender: Any) {
        print("zg")
    }
    
}
