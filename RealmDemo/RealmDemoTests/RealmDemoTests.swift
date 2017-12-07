//
//  RealmDemoTests.swift
//  RealmDemoTests
//
//  Created by Max Rogers on 12/1/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RealmDemo

class RealmDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        // Clear Realm before each test is run
        RealmRemove.clearRealmDatabase()
    }
    
    override func tearDown() {
        // Code to run after each test should be placed here
        super.tearDown()
    }
    
    // MARK: - Tests for items to be displayed
    
    func testItemsQuery() {
        let item1 = Item(id: "test1id", name: "test1", price: 5)
        let item2 = Item(id: "test2id", name: "test2", price: 10)
        let item3 = Item(id: "test3id", name: "test3", price: 15)
        
        let itemList = [item1, item2, item3]
        
        for item in itemList {
            RealmWrite.insert(item: item)
        }
        
        // Test price limit == 0
        
        let itemsWithinZero = RealmQuery.items(withPriceLimit: 0)
        XCTAssertEqual(itemsWithinZero.count, 0)
        
        // Test price limit == 5
        
        let itemsWithinFive = RealmQuery.items(withPriceLimit: 5)
        XCTAssertEqual(itemsWithinFive.count, 1)
        XCTAssert(itemsWithinFive.contains(item1))
        
        // Test price limit == 10
        
        let itemsWithinTen = RealmQuery.items(withPriceLimit: 10)
        XCTAssertEqual(itemsWithinTen.count, 2)
        XCTAssert(itemsWithinTen.contains(item1) && itemsWithinTen.contains(item2))
        
        // Test price limit == 15
        
        let itemsWithinFifteen = RealmQuery.items(withPriceLimit: 15)
        XCTAssertEqual(itemsWithinFifteen.count, 3)
        XCTAssert(itemsWithinFifteen.contains(item1) && itemsWithinFifteen.contains(item2) && itemsWithinFifteen.contains(item3))
    }
    
    // MARK: - Tests for updating items
    
    func testItemUpdate() {
        
        let testItem = Item(id: "test", name: "testItem", price: 300)
        
        RealmWrite.insert(item: testItem)
        var queriedItem = RealmQuery.item(withID: "test")!
        
        XCTAssertEqual(queriedItem.name, "testItem")
        XCTAssertEqual(queriedItem.price, 300)
        
        RealmWrite.update(item: queriedItem, withName: "updatedName", andPrice: 444)
        queriedItem = RealmQuery.item(withID: "test")!
        
        XCTAssertEqual(queriedItem.name, "updatedName")
        XCTAssertEqual(queriedItem.price, 444)
        
    }
     
    
}
