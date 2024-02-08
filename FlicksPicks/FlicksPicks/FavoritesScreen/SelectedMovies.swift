//
//  SelectedMovies.swift
//  FlicksPicks
//
//  Created by User on 04.01.2024.
//

import UIKit

final class SelectedMovies: UITableViewController {
    // MARK: Properties
    private var viewModel: GeneralViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SelectedMovieCell.self, forCellReuseIdentifier: "SelectedMovieCell")
        
        viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
        
        setTrashButton()
    }
    
    // MARK: - Private func
    @objc func cleanTableItems() {
        viewModel.selectedMovies.removeAll()
    }
    
    private func setTrashButton() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanTableItems))
        navigationItem.rightBarButtonItem = trashButton
    }
}

// MARK: - UITableViewDataSource
extension SelectedMovies {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.selectedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.selectedMovies[indexPath.item]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedMovieCell",
                                                       for: indexPath) as? SelectedMovieCell else { return UITableViewCell() }
        cell.set(movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectedMovies {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let response = viewModel.movies[indexPath.item]
        let movieVC = Movie(viewModel: response)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            self?.viewModel.selectedMovies.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
