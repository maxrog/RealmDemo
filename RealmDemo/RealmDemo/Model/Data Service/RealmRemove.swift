//
//  RealmRemove.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRemove {
    
    // MARK: - Delete a specific item
    
    static func delete(item: Item) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch let error {
            print("Delete transaction for item failed", error)
        }
    }
    
    // MARK: - Delete all items
    
    static func deleteAllItems() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(Item.self))
            }
        } catch let error {
            print("Delete transaction for all items failed", error)
        }
    }
    
    // MARK: - Clear entire database
    
    static func clearRealmDatabase() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print("Delete transaction for all of realm failed", error)
        }
    }
    
}
