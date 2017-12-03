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
    
    static func items(withPriceLimit limit: Int) -> [Item]? {
        do {
            let realm = try Realm()
            let validItems = realm.objects(Item.self).filter("price <= \(limit)")
            
            return Array(validItems)
        } catch let error {
            print("Query for items failed", error)
        }
        return nil
    }
    
    // MARK: - Query item with specific ID
    
    static func item(withID id: String) -> Item? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Item.self, forPrimaryKey: id)
        } catch let error {
            print("Query for item with id failed", error)
        }
        return nil
    }
    
    
}
