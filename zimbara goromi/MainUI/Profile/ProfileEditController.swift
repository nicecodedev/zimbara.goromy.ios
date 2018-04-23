//
//  ProfileEditController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 18.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ProfileEditController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var titleString: String? {
        didSet { label?.text = titleString }
    }
    var textString: String? {
        didSet { textField?.text = textString }
    }
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = self.view.bounds
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        view.insertSubview(blurView, at: 0)

        label?.text = titleString
        textField?.text = textString
        
        textField?.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let height = keyboardFrame.cgRectValue.height
            buttonBottomConstraint?.constant = 15 + height
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        blurView.frame = view.bounds
    }
    
    @IBAction func close(_ sender: Any) {
        textField?.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @IBAction func confirm(_ sender: Any) {
        textField?.resignFirstResponder()
        dismiss(animated: true)
    }
    

}
