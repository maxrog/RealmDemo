//
//  RealmWrite.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrite {
    
    // MARK: - Insert a new item or update an existing one
    
    static func insert(item: Item) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: true)
            }
        } catch let error {
            print("Write transaction for item failed", error)
        }
    }
    
}
