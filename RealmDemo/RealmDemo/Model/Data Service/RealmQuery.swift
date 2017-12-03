//
//  RealmQuery.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation
import RealmSwift

class RealmQuery {
    
    // MARK: - Query items within price range
    
    static func items(withPriceLimit limit: Int) -> [Item] {
        let realm = RealmProvider.realm()
        let validItems = realm.objects(Item.self).filter("price <= \(limit)")
        
        return Array(validItems)
    }
    
    // MARK: - Query item with specific ID
    
    static func item(withID id: String) -> Item? {
        let realm = RealmProvider.realm()
        return realm.object(ofType: Item.self, forPrimaryKey: id)
    }
    
    // MARK: - Query all items
    
    static func allItems() -> [Item] {
        let realm = RealmProvider.realm()
        let items = realm.objects(Item.self)
        return Array(items)
    }
    
    
}
