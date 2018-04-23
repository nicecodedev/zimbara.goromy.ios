//
//  ProfileControllerViewController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 17.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
//    var gradientBackgroundLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gradientBackgroundLayer = view.addBackgroundGradientLayer(withColors: [RGB_A(135, 23, 194, ALPHA: 1), RGB_A(55, 217, 180, ALPHA: 1)])

        (navigationController?.navigationBar as? NavigationBar)?.applyLightStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProfileEditController {
            if segue.identifier == "editLogin" {
                destination.titleString = "e-mail"
                destination.textString = "jeremy1002@yandex.ru"
            }
            if segue.identifier == "editName" {
                destination.titleString = "Имя"
                destination.textString = "Артем"
            }
        }
    }

    @IBAction func openMenu(_ sender: Any) {
        MainMenuContainerController.shared?.showMenu()
    }
    
    @IBAction func editLogin(_ sender: Any) {
        performSegue(withIdentifier: "editLogin", sender: self)
    }
    
    @IBAction func editName(_ sender: Any) {
        performSegue(withIdentifier: "editName", sender: self)
    }
    
}
