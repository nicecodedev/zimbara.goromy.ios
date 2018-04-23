//
//  AlertController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class AlertController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: AlertControllerDelegate!
    
    private lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = self.view.bounds
        view.layer.opacity = 0.95
        self.view.insertSubview(view, at: 0)
        return view
    }()
    
    private var message: String!
    private var actions: Array<AlertAction> = []
    private var style: AlertControllerStyle!
    
    static var newAlert: AlertController {
        let alertController = AlertController(nibName: "AlertController", bundle: nil)
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overFullScreen
        return alertController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
//        view.addGestureRecognizer(tapRecognizer)
        
        containerView?.layer.shadowColor = RGB_A(0x52, 0x63, 0x68, ALPHA: 0.19).cgColor
        containerView?.layer.shadowOffset = CGSize(width: 1, height: 2)
        containerView?.layer.shadowRadius = 2
        containerView?.layer.shadowOpacity = 1.0

        messageLabel?.text = message ?? ""
        
        for action in actions {
            let button = UIButton()
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(action.style.color, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            button.tag = action.tag
            button.addTarget(self, action: #selector(actionSelected(_:)), for: .touchUpInside)
            stackView?.addArrangedSubview(button)
        }
        
        switch style! {
        case .rows:
            if actions.isEmpty {
                stackViewHeightConstraint?.constant = 0
            } else {
                let constant: CGFloat = CGFloat(actions.count) * 70 + CGFloat(actions.count - 1)
                stackViewHeightConstraint?.constant = constant
            }
        case .alert:
            stackViewHeightConstraint?.constant = actions.isEmpty ? 0 : 70
        }
        
        switch style! {
        case .alert: stackView.axis = .horizontal
        case .rows: stackView.axis = .vertical
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        blurView.frame = view.bounds
    }

    func set(message: String) {
        self.message = message
    }
    
    func set(style: AlertControllerStyle) {
        self.style = style
    }
    
    func addAction(withTitle title: String, tag: Int, ansStyle style: AlertControllerActionStyle) {
        let alertAction = AlertAction(title: title, tag: tag, style: style)
        actions.append(alertAction)
    }
    
    @objc private func viewTapped() {
        dismiss(animated: true)
    }
    
    @objc private func actionSelected(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.alertController(didSelectActionWithTag: sender.tag)
        }
    }
    
}

fileprivate struct AlertAction {
    var title: String
    var tag: Int
    var style: AlertControllerActionStyle
}

enum AlertControllerStyle {
    case alert, rows
}

enum AlertControllerActionStyle {
    case normal, destructive
    
    var color: UIColor {
        switch self {
        case .normal: return RGB_A(0x27, 0x3D, 0x52, ALPHA: 1)
        case .destructive: return RGB_A(0xF5, 0x08, 0x08, ALPHA: 1)
        }
    }
}

protocol AlertControllerDelegate: class {
    func alertController(didSelectActionWithTag tag: Int)
}
