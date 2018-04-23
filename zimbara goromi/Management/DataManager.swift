//
//  DataManager.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class DataManager {
    
    private let realm = try! Realm()
    private let defaults = UserDefaults.standard
    private let fileManager = FileManager.default
    
    struct Keys {
        static let currentLanguageId = "current.language.id"
    }
    
    var currentBookLanguage: LanguageModel? {
        get {
            guard let currentLanguageId = defaults.value(forKey: Keys.currentLanguageId) as? Int else { return nil }
            return realm.objects(LanguageModel.self).first { $0.id == currentLanguageId }
        }
        set {
            guard let newLanguageId = newValue?.id else { return }
            defaults.set(newLanguageId, forKey: Keys.currentLanguageId)
        }
    }
    var booksLanguages: Results<LanguageModel> {
        return realm.objects(LanguageModel.self)
    }
    
    var marketBooks: Results<BookListModel> {
        return realm.objects(BookListModel.self)
    }
    
    func update(languages: Array<LanguageModel>, completed: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main, execute: completed)
        for language in languages {
            if let url = URL(string: language.flag) {
                dispatchGroup.enter()
                downloadFile(fromUrl: url, withName: language.flag_file_name, completed: dispatchGroup.leave)
            }
        }
        try! realm.write {
            realm.add(languages, update: true)
        }
        dispatchGroup.leave()
    }
    
    func update(marketBooks: Array<BookListModel>, completed: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main, execute: completed)
        for book in marketBooks {
            if let filePreview = book.preview, let url = WebApiRouter.url(forPreviewPath: filePreview.file) {
                dispatchGroup.enter()
                downloadFile(fromUrl: url, withName: filePreview.preview_file_name, completed: dispatchGroup.leave)
            }
        }
        try! realm.write {
            realm.add(marketBooks, update: true)
        }
        dispatchGroup.leave()
    }
    
    // files
    func file(named name: String) -> Data? {
        var url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url.appendPathComponent(name)
        return fileManager.contents(atPath: url.path)
    }
    private func fileDestination(forFileNamed name: String) -> DownloadRequest.DownloadFileDestination {
        return { _, _ in
            var url = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            url.appendPathComponent(name)
            return (url, DownloadRequest.DownloadOptions.removePreviousFile)
        }
    }
    func downloadFile(fromUrl url: URL, withName name: String, completed: @escaping () -> Void) {
        guard !existsFile(named: name) else {
            completed()
            return
        }
        Alamofire.download(url, to: fileDestination(forFileNamed: name)).response { _ in
            completed()
        }
    }
    private func existsFile(named name: String) -> Bool {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return false }
        guard var url = try? path.asURL() else { return false }
        url.appendPathComponent(name)
        return fileManager.fileExists(atPath: url.path)
    }
    
}
