//
//  SymbolCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 22.03.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class SymbolCell: UICollectionViewCell {
    
    @IBOutlet weak var symbolImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        symbolImageView?.image = randomSymbolImage
    }
    
    var randomSymbolImage: UIImage? {
        let random = Int(arc4random_uniform(34))
        let symbolImageName = "symbol_\(random)"
        let image = UIImage(named: symbolImageName)
        return image
    }

}
