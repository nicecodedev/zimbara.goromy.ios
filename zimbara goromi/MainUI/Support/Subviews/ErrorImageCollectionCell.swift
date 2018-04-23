//
//  ErrorImageCollectionCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class ErrorImageCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    
    weak var delegate: ErrorImageCollectionCellDelegate!
    
    var image: UIImage! {
        didSet { imageView?.image = image }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFill
        imageView?.layer.cornerRadius = 7
        imageView?.layer.borderColor = RGB_A(223, 223, 223, ALPHA: 1).cgColor
        imageView?.layer.borderWidth = 1
    }

    @IBAction private func deleteImage(_ sender: Any) {
        delegate?.deleteImage(self)
    }
    
}

protocol ErrorImageCollectionCellDelegate: class {
    func deleteImage(_ errorImageCollectionCell: ErrorImageCollectionCell)
}
