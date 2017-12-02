//
//  ItemTableViewCell.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Properties
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    typealias T = Item
    var model: Item?
    
    func configure(with model: Item) {
        self.model = model
        itemNameLabel.text = model.name
        itemPriceLabel.text = "$\(model.price)"
    }

}
