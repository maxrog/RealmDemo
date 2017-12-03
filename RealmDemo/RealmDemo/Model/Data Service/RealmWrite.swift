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
    
    // MARK: - Insert a new item
    
    static func insert(item: Item) {
        do {
            let realm = RealmProvider.realm()
            print(realm.configuration.inMemoryIdentifier)
            try realm.write {
                realm.add(item, update: true)
            }
        } catch let error {
            print("Write transaction for item failed", error)
        }
    }
    
    // MARK: - Update an existing itme
    
    static func update(item: Item, withName name: String, andPrice price: Int) {
        do {
            let realm = RealmProvider.realm()
            try realm.write {
                item.name = name
                item.price = price
                realm.add(item, update: true)
            }
        } catch let error {
            print("Write transaction for update item failed", error)
        }
    }
    
}
