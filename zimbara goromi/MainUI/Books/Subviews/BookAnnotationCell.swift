//
//  BookAnnotationCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 04.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class BookAnnotationCell: UITableViewCell {

    @IBOutlet private weak var annotationLabel: UILabel!
    
    var annotationText: String? {
        didSet { annotationLabel?.text = annotationText }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
