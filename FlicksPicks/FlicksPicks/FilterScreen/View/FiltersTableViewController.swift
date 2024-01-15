//
//  Filters.swift
//  FlicksPicks
//
//  Created by User on 04.01.2024.
//

import UIKit

final class FiltersTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: "FiltersTableViewCell")
    }
}
