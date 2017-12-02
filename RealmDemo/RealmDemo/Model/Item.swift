//
//  Item.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    // MARK: - Properties
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var price = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
