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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SelectedMovieCell.self, forCellReuseIdentifier: "SelectedMovieCell")
        
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension SelectedMovies {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.selectedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.selectedMovies[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedMovieCell",
                                                       for: indexPath) as? SelectedMovieCell else { return UITableViewCell() }
        cell.set(movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectedMovies {
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let response = viewModel.movies[indexPath.row]
        let movieVC = Movie(viewModel: response)
        
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
