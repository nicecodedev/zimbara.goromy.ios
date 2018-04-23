//
//  WelcomePresenter.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation

protocol iWelcomePresenter {
    var view: WelcomeView! { get set }
    func checkSettings()
}

class WelcomePresenter: iWelcomePresenter {
    
    weak var view: WelcomeView!
    
    private let dataManager = DataManager()
    
    func checkSettings() {
        
        if dataManager.currentBookLanguage == nil {
            
            let router = WebApiRouter.booksLanguages(authorization: nil)
            WebApiManager.use(router: router) { response in
                guard response.success, let languages: Array<LanguageModel> = response.collection(), !languages.isEmpty else {
                    DispatchQueue.main.async {
                        self.view?.showConnectionLost()
                    }
                    return
                }
                print(languages)
                
                self.dataManager.update(languages: languages) {
                    self.view?.setNeedsOpenApp()
                }
                
            }
            
        } else {
            
            DispatchQueue.main.async {
                self.view?.setNeedsOpenApp()
            }
            
        }
        
    }
    
    private func setupDefaultLanguage() {
        // set default language
        if let currentLanguageCodeString = Locale.current.languageCode {
            print(currentLanguageCodeString)
            if let language = dataManager.booksLanguages.first(where: { $0.code == currentLanguageCodeString }) {
                dataManager.currentBookLanguage = language
            } else if let language = dataManager.booksLanguages.first(where: { $0.code == "en" }) {
                dataManager.currentBookLanguage = language
            } else {
                dataManager.currentBookLanguage = dataManager.booksLanguages.first
            }
        } else {
            dataManager.currentBookLanguage = dataManager.booksLanguages.first
        }
        
        print("CURRENT LANGUAGE: \(dataManager.currentBookLanguage)")
    }
    
}
