//
//  SelectedMovies.swift
//  FlicksPicks
//
//  Created by User on 04.01.2024.
//

import UIKit

final class SelectedMovies: UITableViewController {
    // MARK: Properties
    private var viewModel: SelectedMovieViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: SelectedMovieViewModelProtocol) {
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
        registerObserver()
        
        viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
        
        setTrashButton()
    }
    
    // MARK: - Private func
    @objc private func cleanTableItems() {
        //        viewModel.selectedMovies.removeAll()
        viewModel.deleteAll()
    }
    
    @objc private func updateData() {
        viewModel.getMovies()
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name: NSNotification.Name("Update"),
                                               object: nil)
    }
    
    private func setTrashButton() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, 
                                          target: self,
                                          action: #selector(cleanTableItems))
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
        let currentMovie = viewModel.selectedMovies[indexPath.item]
        let movieVC = Movie(viewModel: currentMovie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            if let self {
                self.viewModel.deleteMovie(self.viewModel.selectedMovies[indexPath.item])
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
