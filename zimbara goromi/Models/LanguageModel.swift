//
//  LanguageModel.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import SwiftyJSON
import Realm
import RealmSwift

class LanguageModel: Object, WebApiCoding {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var flag: String = ""
    
    var flag_file_name: String {
        return "flag_file_\(id)"
    }
    
    convenience required init?(_ json: JSON?) {
        self.init()
        guard let json = json else { return nil }
        id = json["id"].intValue
        code = json["code"].stringValue
        name = json["name"].stringValue
        flag = json["flag"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
