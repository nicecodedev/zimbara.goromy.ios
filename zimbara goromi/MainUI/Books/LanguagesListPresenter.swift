//
//  LanguagesListPresenter.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

protocol iLanguagesListPresenter {
    
    var view: LanguagesListView! { get set }
    
    var languagesTotal: Int { get }
    func language(at index: Int) -> LanguageItem
    
    func fetchLanguages()
    func selectLanguage(at index: Int)
}

class LanguagesListPresenter: iLanguagesListPresenter {
    
    weak var view: LanguagesListView!
    
    let dataManager = DataManager()
    
    var languagesTotal: Int {
        return languageFetchCompleted ? dataManager.booksLanguages.count : 0
    }
    
    var languageFetchCompleted = false
    
    func language(at index: Int) -> LanguageItem {
        let language = dataManager.booksLanguages[index]
        let isCurrent = language.id == dataManager.currentBookLanguage?.id
        let item = (language.name, dataManager.file(named: language.flag_file_name)?.asImage(), isCurrent)
        return item
    }
    
    func fetchLanguages() {
        
        WebApiManager.use(router: .booksLanguages(authorization: nil)) { response in
            
            print("LANGUAGE FETCH COMPLETED")
            self.languageFetchCompleted = true
            
            if response.success, let languages: Array<LanguageModel> = response.collection(), !languages.isEmpty {
                self.dataManager.update(languages: languages) { [weak self] in
                    self?.view?.reloadList()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.reloadList()
                }
            }
            
        }
        
    }
    
    func selectLanguage(at index: Int) {
        let language = dataManager.booksLanguages[index]
        dataManager.currentBookLanguage = language
        
        DispatchQueue.main.async {
            self.view?.reloadList()
        }
    }
}

typealias LanguageItem = (name: String, image: UIImage?, isCurrent: Bool)
