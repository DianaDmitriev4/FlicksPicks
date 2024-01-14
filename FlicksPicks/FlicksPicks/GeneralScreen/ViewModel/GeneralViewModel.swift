//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import Foundation

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
    func loadData(count: Int)
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var movies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    // MARK: - Methods
    func loadData(count: Int) {
        ApiManager.getFilms(count: count) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    // MARK: - Private methods
    private func handleResult(result: (Result<MovieResponse, Error>)) {
        switch result {
        case .success(let movie):
            convertToMovieResponse(movie)
            getImage()
        case .failure(let error):
            DispatchQueue.main.async { [ weak self ] in
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    private func convertToMovieResponse(_ response: MovieResponse) {
        let movieResponseViewModel = MovieResponseViewModel(response)
        movies.append(movieResponseViewModel)
    }
    
    private func getImage() {
        for (i, film) in movies.enumerated() {
            let url = film.poster
            ApiManager.getImage(url: url) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let movie = self?.movies[i]
                        movie?.imageData = data
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
}
