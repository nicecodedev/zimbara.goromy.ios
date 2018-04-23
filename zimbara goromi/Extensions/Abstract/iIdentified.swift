//
//  iIdentified.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

protocol iIdentified {
    static var identifier: String { get }
    static var storyboard: String { get }
}

extension UIViewController {
    static func from<T: UIViewController>(_ identified: iIdentified.Type) -> T! {
        return UIStoryboard(name: identified.storyboard, bundle: nil).instantiateViewController(withIdentifier: identified.identifier) as? T
    }
}

//extension ContentNavigationController: iIdentified {
//    static var identifier: String { return "" }
//    static var storyboard: String { return "" }
//}

// main
extension MainMenuContainerController: iIdentified {
    static var identifier: String { return "main.menu.container.controller" }
    static var storyboard: String { return "Main" }
}

extension MainMenuController: iIdentified {
    static var identifier: String { return "main.menu.controller" }
    static var storyboard: String { return "Main" }
}

// books
extension BooksNavigationController: iIdentified {
    static var identifier: String { return "books.navigation.controller" }
    static var storyboard: String { return "Books" }
}

// login
extension LoginSignInController: iIdentified {
    static var identifier: String { return "login.sign.in.controller" }
    static var storyboard: String { return "Login" }
}

// tutorial
extension TutorialController: iIdentified {
    static var identifier: String { return "tutorial.tutorial.controller" }
    static var storyboard: String { return "Tutorial" }
}

// support
extension SupportNavigationController: iIdentified {
    static var identifier: String { return "support.navigation.controller" }
    static var storyboard: String { return "Support" }
}

// settings
extension SettingsNavigationController: iIdentified {
    static var identifier: String { return "settings.navigation.controller" }
    static var storyboard: String { return "Settings" }
}

// about
extension AboutNavigationController: iIdentified {
    static var identifier: String { return "about.navigation.controller" }
    static var storyboard: String { return "About" }
}

// profile
extension ProfileNavigationController: iIdentified {
    static var identifier: String { return "profile.navigation.controller" }
    static var storyboard: String { return "Profile" }
}
