//
//  BookBuyCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 04.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class BookBuyCell: UITableViewCell {
    
    @IBOutlet private weak var button: GradientButton!
    
    var delegate: BuyBookCellDelegate!
    
    var buttonText: String? {
        didSet { }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.layer.shadowColor = RGB_A(37, 38, 94, ALPHA: 0.1).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 1.0
    }
    
    @IBAction private func buy(_ sender: Any) {
        delegate?.buyBookCell(buyPressedFor: self)
    }
    
}

protocol BuyBookCellDelegate {
    func buyBookCell(buyPressedFor buyBookCell: BookBuyCell)
}
