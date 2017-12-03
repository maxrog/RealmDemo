//
//  ItemDetailViewController.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    
    var item: Item?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            itemNameTextField.text = item.name
            itemPriceTextField.text = "\(item.price)"
        }
    }
    
    // MARK: IBActions
    
    @IBAction func addItem(_ sender: UIButton) {
        guard let name = itemNameTextField.text,
            let priceString = itemPriceTextField.text,
            let price = Int(priceString) else { return }
        
        let item = Item(name: name, price: price)
        RealmWrite.insert(item: item)
        
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Textfield Delegate

extension ItemDetailViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
