//
//  SymbolsGridView.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 18.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
class SymbolsGridView: UIView {

    private let imageSizeConstant: CGFloat = 35.0
    
    private var rows: Int = 0
    private var columns: Int = 0
    
    private var hMargin: CGFloat {
        let columns = CGFloat(self.columns)
        let totalColumnsWidth = columns * imageSizeConstant
        let delta = frame.width - totalColumnsWidth
        return delta / (columns - 1)
    }
    private var vMargin: CGFloat {
        let rows = CGFloat(self.rows)
        let totalRowsHeight = rows * imageSizeConstant
        let delta = frame.height - totalRowsHeight
        return delta / (rows - 1)
    }
    
    var imageViews: Array<UIImageView> = []
    
    override func draw(_ rect: CGRect) {
        
        if imageViews.isEmpty {
            rows = Int(floor((rect.height * 0.8) / imageSizeConstant))
            columns = Int(floor((rect.width * 0.8) / imageSizeConstant))
            
            __enumerate(rows, columns) { row, column in
                let column = CGFloat(column)
                let row = CGFloat(row)
                let x: CGFloat = column * imageSizeConstant + column * hMargin
                let y: CGFloat = row * imageSizeConstant + row * vMargin
                let frame = CGRect(x: x, y: y, width: imageSizeConstant, height: imageSizeConstant)
                let imageView = UIImageView(image: generateImage())
                imageView.frame = frame
                imageView.contentMode = .scaleAspectFit
                imageView.layer.opacity = 0.0
                imageViews.append(imageView)
            }
            
            imageViews.forEach { imageView in
                self.addSubview(imageView)
            }
            
        }
        
    }
    
    private func generateImage() -> UIImage! {
        let random = arc4random_uniform(34)
        let name = "symbol_\(random)"
        print(name)
        return UIImage(named: name)
    }
    
    func runAnimation(completed: @escaping () -> Void) {
        
        var imageViews = Array(self.imageViews)
        
        while !imageViews.isEmpty {
            let index = Int(arc4random_uniform(UInt32(imageViews.count)))
            let imageView = imageViews[index]
            let randomDelay = Double(arc4random_uniform(10)) / 10
            UIView.animate(withDuration: 0.3, delay: randomDelay, options: .curveLinear, animations: {
                imageView.layer.opacity = 1.0
            })
            imageViews.remove(at: index)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.hideExtraImages {
                completed()
            }
        }
        
    }
    
    private func hideExtraImages(completed: @escaping () -> Void) {
        
        for (index, imageView) in self.imageViews.enumerated() {
            if !neededIndexes.contains(index) {
                let randomDelay = Double(arc4random_uniform(10)) / 10
                UIView.animate(withDuration: 0.3, delay: randomDelay, options: .curveLinear, animations: {
                    imageView.layer.opacity = 0.0
                })
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: completed)

    }

    private lazy var neededIndexes: Set<Int> = {
        var set: Set<Int> = []
        while set.count < 13 {
            let randomIndex = Int(arc4random_uniform(UInt32(self.imageViews.count)))
            set.insert(randomIndex)
        }
        return set
    }()
    
    func moveImages(to points: Array<CGPoint>, withStart startPoint: CGPoint, completed: @escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7, execute: completed)
        
        for (index, point) in zip(neededIndexes, points) {
            UIView.animate(withDuration: 0.5, animations: {
                self.imageViews[index].frame.origin = CGPoint(x: startPoint.x + point.x, y: startPoint.y + point.y)
            })
        }
    }
}
