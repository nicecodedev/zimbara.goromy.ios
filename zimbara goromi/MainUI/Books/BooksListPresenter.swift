//
//  BooksListPresenter.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

protocol iBooksListPresenter {
    
    var view: BooksListView! { get set }
    var languageImage: UIImage? { get }
    
    var booksTotal: Int { get }
    func book(at index: Int) -> BookItem
    
    func fetchBooks()
}

class BooksListPresenter: iBooksListPresenter {
    
    weak var view: BooksListView!

    let dataManager = DataManager()
    
    var languageImage: UIImage? {
        guard let language = dataManager.currentBookLanguage else { return nil }
        return dataManager.file(named: language.flag_file_name)?.asImage()?.af_imageAspectScaled(toFill: CGSize(width: 25, height: 25))
    }
    
    var booksTotal: Int {
        return booksFetchEnded ? dataManager.marketBooks.count : 0
    }
    
    func book(at index: Int) -> BookItem {
        let book = dataManager.marketBooks[index]
        let image = dataManager.file(named: book.preview?.preview_file_name ?? "")?.asImage()
        return (book.title, image)
    }
    
    var booksFetchEnded = false
    
    func fetchBooks() {
        
        guard let languageCode = dataManager.currentBookLanguage?.code else {
            DispatchQueue.main.async {
                self.view?.showBooks()
            }
            return
        }
        
        WebApiManager.use(router: .booksFor(languageCode: languageCode, authorization: nil)) { response in
            
            self.booksFetchEnded = true
            
            if response.success, let books: Array<BookListModel> = response.collection(), !books.isEmpty {
                self.dataManager.update(marketBooks: books) {
                    self.view?.showBooks()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.showBooks()
                }
            }
            
        }
    
    }
    
}

typealias BookItem = (name: String, image: UIImage?)
