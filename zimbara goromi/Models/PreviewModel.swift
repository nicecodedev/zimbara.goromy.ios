//
//  PreviewModel.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class PreviewModel: Object, WebApiCoding {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var file: String = ""
    
    var preview_file_name: String {
        return "preview_file_\(id)"
    }
    
    convenience required init?(_ json: JSON?) {
        self.init()
        guard let json = json else { return nil }
        id = json["id"].intValue
        file = json["file"].stringValue
    }
    
}

