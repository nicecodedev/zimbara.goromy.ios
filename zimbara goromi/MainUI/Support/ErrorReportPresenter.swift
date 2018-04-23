//
//  ErrorReportPresenter.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 12.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

protocol iErrorReportPresenter {
    var view: ErrorReportView! { get set }
    
    var totalImages: Int { get }
    
    func add(image: UIImage)
    func removeImage(atIndex index: Int)
    func image(atIndex index: Int) -> UIImage
}

class ErrorReportPresenter: iErrorReportPresenter {
    
    weak var view: ErrorReportView!
    
    var images: Array<UIImage> = []
    var totalImages: Int { return images.count }
    
    func add(image: UIImage) {
        images.append(image)
        
        DispatchQueue.main.async {
            self.view?.reloadImages()
        }
    }
    
    func removeImage(atIndex index: Int) {
        images.remove(at: index)
        
        DispatchQueue.main.async {
            self.view?.reloadImages()
        }
    }
    
    func image(atIndex index: Int) -> UIImage {
        return images[index]
    }
    
}
