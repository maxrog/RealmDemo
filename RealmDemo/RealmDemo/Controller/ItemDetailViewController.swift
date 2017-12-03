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
    
    var itemToEdit: Item?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemNameTextField.delegate = self
        
        if let item = itemToEdit {
            itemNameTextField.text = item.name
            itemPriceTextField.text = "\(item.price)"
        }
    }
    
    // MARK: Actions
    
    @IBAction func addItem(_ sender: UIButton) {
        guard let name = itemNameTextField.text,
            let priceString = itemPriceTextField.text,
            let price = Int(priceString) else { return }
        
        // Existing item to update
        if let editedItem = itemToEdit {
            RealmWrite.update(item: editedItem, withName: name, andPrice: price)
        } else {
            // New item to add
            let item = Item(name: name, price: price)
            RealmWrite.insert(item: item)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}

// MARK: - Textfield Delegate

extension ItemDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemNameTextField.resignFirstResponder()
        return true
    }
    
}
