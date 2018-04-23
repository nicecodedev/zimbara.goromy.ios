//
//  BookListModel.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class BookListModel: Object, WebApiCoding {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var preview: PreviewModel!
    let last_modified = List<LastModifiedModel>()
    
    convenience required init?(_ json: JSON?) {
        self.init()
        guard let json = json else { return nil }
        id = json["id"].intValue
        title = json["title"].stringValue
        preview = PreviewModel(json["preview"])
        let dateFormatter = DateFormatter.standard()
        last_modified.append(objectsIn: json["last_modified"].dictionaryValue.map { tuple in
            let lastModified = LastModifiedModel()
            lastModified.code = tuple.key
            lastModified.date = dateFormatter.date(from: tuple.value.stringValue)
            return lastModified
        })
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
