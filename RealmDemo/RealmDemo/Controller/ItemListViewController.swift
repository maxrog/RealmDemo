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
    
    var priceLimit = 5 {
        didSet {
            priceLimitLabel.text = "$\(priceLimit)"
            items = RealmQuery.items(withPriceLimit: priceLimit)
        }
    }
    var items: [Item]? {
        didSet {
            tableView.reloadData()
        }
    }
    var itemToPass: Item?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = RealmQuery.items(withPriceLimit: priceLimit)
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
        guard let detailVC = segue.destination as? ItemDetailViewController else { return }
        
        if segue.identifier == "addItem" {
            detailVC.title = "Create Item"
        } else {
            guard let item = itemToPass else { return }
            detailVC.title = "ID: \(item.id)"
            detailVC.itemToEdit = itemToPass
        }
    }
    
}

// MARK: - Tableview datasource & delegate

extension ItemListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = items {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell,
        let items = items else { return UITableViewCell() }
        
        itemCell.configure(with: items[indexPath.row])
        
        return itemCell
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
            guard let itemCell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell,
                let item = itemCell.model else { return }
            RealmRemove.delete(item: item)
            items = RealmQuery.items(withPriceLimit: priceLimit)
        }
    }

}
