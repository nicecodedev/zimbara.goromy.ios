//
//  LastModifiedModel.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class LastModifiedModel: Object {
    
    @objc dynamic var code: String = ""
    @objc dynamic var date: Date!
    
}
