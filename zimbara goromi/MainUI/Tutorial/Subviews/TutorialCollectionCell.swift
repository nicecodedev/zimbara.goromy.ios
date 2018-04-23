//
//  TutorialCollectionCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 10.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class TutorialCollectionCell: UICollectionViewCell {

    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var tutorialLabel: UILabel!
    
    var tutorialImage: UIImage! {
        didSet { tutorialImageView?.image = tutorialImage }
    }
    var tutorialText: String! {
        didSet { tutorialLabel?.text = tutorialText }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
