//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import Foundation

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get }
    var showError: ((String) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
    var currentIndex: Int { get set }
    var selectedMovies: [MovieResponseViewModel] { get set}
    var reloadTable: (() -> Void)? { get set }
//    func loadData(count: Int, genre: [GenreTypes]?)
    func loadData()
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadTable: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var movies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    var selectedMovies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadTable?()
            }
        }
    }
    var currentIndex = 0
    
    // MARK: - Methods
//    func loadData(count: Int, genre: [GenreTypes]?) {
//        ApiManager.getFilms(genre: genre, count: count) { [weak self] result in
//            self?.handleResult(result: result)
//        }
//    }
    func loadData() {
        ApiManager.getFilms() { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    // MARK: - Private methods
    private func handleResult(result: (Result<[Doc], Error>)) {
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
    
    private func convertToMovieResponse(_ response: [Doc]) {
        let movieResponseViewModel = response.map { MovieResponseViewModel($0) }
        movies = movieResponseViewModel
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
