//
//  BooksListController.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 03.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import UIKit
import AlamofireImage

class BooksListController: UIViewController {

    @IBOutlet weak var booksCollectionView: UICollectionView!
    @IBOutlet weak var languageButton: UIButton!
    
    var presenter: iBooksListPresenter = BooksListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        
        let bookCellNib = UINib(nibName: "BookListCell", bundle: nil)
        booksCollectionView.register(bookCellNib, forCellWithReuseIdentifier: "bookCell")

        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        
        languageButton?.imageView?.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        languageButton?.imageView?.layer.borderWidth = 1.0
        languageButton?.imageView?.layer.cornerRadius = 3
        
        presenter.fetchBooks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        languageButton.setImage(presenter.languageImage, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = booksCollectionView?.indexPathsForSelectedItems?.first?.row else {
            return
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        MainMenuContainerController.shared?.showMenu()
    }
    
}

protocol BooksListView: class {
    func showBooks()
}

extension BooksListController: BooksListView {
    func showBooks() {
        booksCollectionView?.reloadData()
    }
}

extension BooksListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("go to info")
        self.performSegue(withIdentifier: "info", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.booksTotal
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookListCell
        let (name, image) = presenter.book(at: indexPath.row)
        cell.image = image
        cell.name = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 2.1
        let cellHeight = cellWidth * 1.62
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
