//
//  BookListCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit
import AlamofireImage

class BookListCell: UICollectionViewCell {

    @IBOutlet private weak var imageBackgoundView: UIView!
    
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var image: UIImage? {
        didSet { bookImageView?.image = image }
    }
    var name: String? {
        didSet { nameLabel?.text = name }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBackgoundView.layer.shadowColor = RGB_A(137, 137, 137, ALPHA: 0.5).cgColor
        imageBackgoundView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageBackgoundView.layer.shadowOpacity = 1.0
        imageBackgoundView.layer.shadowRadius = 1
    }

}
