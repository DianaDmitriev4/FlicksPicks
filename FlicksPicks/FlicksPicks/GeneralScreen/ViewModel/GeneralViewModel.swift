//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

// TODO: поставить foundation после того, как засетаю из сети
import Foundation

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get set }
    var showError: ((String) -> Void)? { get set }
    func loadData(count: Int)
    var reloadData: (() -> Void)? { get set }
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var movies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    var showError: ((String) -> Void)?
    
    func loadData(count: Int) {
        ApiManager.getFilms(count: count) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    private func handleResult(result: (Result<MovieResponse, Error>)) {
        switch result {
        case .success(let movie):
            getImage()
            convertToMovieResponse(movie)
            
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
