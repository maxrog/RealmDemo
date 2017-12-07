//
//  Migration.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/7/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import Foundation
import RealmSwift

class Migration {
    
    // MARK: - Function to merge old database with new one
    
    func mergeDB() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
                        
                        // These are examples of different types of migrations that may be needed
                        
                        // Here we set the existing objects new property to a default value
                        newObject?["newStringProperty"] = ""
                        
                        // Here we rename a property
                        migration.renameProperty(onType: Item.className(), from: "price", to: "itemPrice")
                        
                        // Here we combine two properties into a new one called identifier (id + name -> identifier)
                        guard let id = oldObject?["id"] as? String else { fatalError("id is not a string") }
                        guard let name = oldObject?["name"] as? String else { fatalError("name is not a string") }
                        
                        let identifier = name + id
                        
                        newObject?["identifier"] = identifier
                    }
                }
        }
        )
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    // MARK: - Function to simply clear old database to start using new schema
    
    func clearOldDB() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            // Set new schema version
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
        },
            deleteRealmIfMigrationNeeded: true
        )
    }
    
}
