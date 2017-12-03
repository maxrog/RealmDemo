//
//  ItemListViewController.swift
//  RealmDemo
//
//  Created by Max Rogers on 12/2/17.
//  Copyright © 2017 Max Rogers. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLimitLabel: UILabel!
    
    var priceLimit = 1 {
        didSet {
            priceLimitLabel.text = "$\(priceLimit)"
            // TODO: - query realm with limit and set items value
            // itmes = realmquery.getItems(withLimit: priceLimit)
        }
    }
    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var itemToPass: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - IBActions
    
    @IBAction func incrementLimit(_ sender: UIButton) {
        priceLimit += 1
    }
    
    @IBAction func decrementLimit(_ sender: UIButton) {
        priceLimit -= 1
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!isEditing, animated: true)
        isEditing = !isEditing
    }
    
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            navigationItem.title = "Create Item"
        } else {
            guard let item = itemToPass else { return }
            navigationItem.title = "ID: \(item.id)"
        }
    }
    

}

// MARK: - Tableview datasource & delegate

extension ItemListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemCell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell else { return }
        itemToPass = itemCell.model
        performSegue(withIdentifier: "editItem", sender: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //TODO: Remove from Realm & reload tableview
            guard let itemCell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell,
                let item = itemCell.model else { return }
            
        }
    }

}
