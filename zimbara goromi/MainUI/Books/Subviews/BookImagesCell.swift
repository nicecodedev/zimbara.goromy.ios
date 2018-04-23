//
//  BookImagesCell.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit

class BookImagesCell: UITableViewCell {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dataSource: BookImageCellDataSource!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let imageCellNib = UINib(nibName: "BookImageCollectionCell", bundle: nil)
        imagesCollectionView.register(imageCellNib, forCellWithReuseIdentifier: "imageCell")
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        pageControl.numberOfPages = 4
    }
    
}

extension BookImagesCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! BookImageCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: collectionView.frame.width * 0.99, height: collectionView.frame.height * 0.99)
//        return size
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(index)
    }
}

protocol BookImageCellDataSource {
    
}
