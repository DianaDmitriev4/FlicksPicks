//
//  Filters.swift
//  FlicksPicks
//
//  Created by User on 04.01.2024.
//

import UIKit

final class FiltersTableViewController: UITableViewController {
    // MARK: Properties
    private var viewModel: FiltersViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: FiltersViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    @objc private func cancelAction() {
        viewModel.selectedGenres = []
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        let vc = GeneralViewController(viewModel: GeneralViewModel())
        vc.genresInUrl = viewModel.selectedGenres
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateFilters"), object: nil)
        //        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: "FiltersTableViewCell")
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
    }
    
    private func isSelected(_ genre: String) -> Bool {
        viewModel.selectedGenres.contains(where: { $0.genreName == genre } )
    }
}

// MARK: - UITableViewDataSource
extension FiltersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.genresType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersTableViewCell",
                                                       for: indexPath) as? FiltersTableViewCell else { return UITableViewCell() }
        let genre = viewModel.genresType[indexPath.row]
        cell.configureCell(genre: genre, isSelected: isSelected(genre))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FiltersTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieType = viewModel.genresType[indexPath.row]
        if isSelected(movieType) {
            viewModel.selectedGenres.removeAll(where: { $0.genreName == movieType })
        } else {
            switch indexPath.row {
            case 0:
                viewModel.selectedGenres.append(GenreTypes.comedy)
            case 1:
                viewModel.selectedGenres.append(GenreTypes.drama)
            case 2:
                viewModel.selectedGenres.append(GenreTypes.actionMovie)
            case 3:
                viewModel.selectedGenres.append(GenreTypes.horror)
            case 4:
                viewModel.selectedGenres.append(GenreTypes.adventures)
            case 5:
                viewModel.selectedGenres.append(GenreTypes.thriller)
            case 6:
                viewModel.selectedGenres.append(GenreTypes.fantastic)
            case 7:
                viewModel.selectedGenres.append(GenreTypes.documentary)
            default:
                break
            }
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
