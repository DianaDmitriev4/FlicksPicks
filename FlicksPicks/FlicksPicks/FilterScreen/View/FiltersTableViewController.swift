////
////  Filters.swift
////  FlicksPicks
////
////  Created by User on 04.01.2024.
////
//
//import UIKit
//
//final class FiltersTableViewController: UITableViewController {
//    // MARK: Properties
//    private let viewModel: FiltersViewModelProtocol
//    
//    // MARK: - Initialization
//    init(viewModel: FiltersViewModelProtocol) {
//        self.viewModel = viewModel
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Life cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .red
//        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: "FiltersTableViewCell")
//    }
//    
//    // MARK: - Private methods
//    private func isSelected(_ genre: FiltersModel) -> Bool {
//        viewModel.selectedGenres.contains(where: <#T##(GenreTypes) throws -> Bool#>)
//    }
//}
//    // MARK: - UITableViewDataSource
//extension FiltersTableViewController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.genresType.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersTableViewCell", 
//                                                       for: indexPath) as? FiltersTableViewCell else { return UITableViewCell() }
//        let genre = viewModel.genresType[indexPath.row]
//        cell.configureCell(genre: genre, isSelected: <#T##Bool#>)
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension FiltersTableViewController {
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//}
//
