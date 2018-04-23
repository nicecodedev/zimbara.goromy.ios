//
//  LanguageCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet private weak var backgroundShadowView: UIView!
    @IBOutlet private weak var borderedView: UIView!
    
    var flagImage: UIImage? {
        didSet { flagImageView?.image = flagImage }
    }
    var name: String? {
        didSet { nameLabel?.text = name }
    }
    var isCurrent: Bool = false {
        didSet { checkImageView?.isHidden = !isCurrent }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let color = RGB_A(229, 236, 237, ALPHA: 1)
        borderedView.layer.cornerRadius = 4
        borderedView.layer.borderColor = color.cgColor
        borderedView.layer.borderWidth = 1
        
        backgroundShadowView.layer.shadowRadius = 2
        backgroundShadowView.layer.shadowOpacity = 1.0
        backgroundShadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundShadowView.layer.shadowColor = color.cgColor
        
        flagImageView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
}
