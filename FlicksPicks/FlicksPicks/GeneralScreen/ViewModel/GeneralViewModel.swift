//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

// TODO: поставить foundation после того, как засетаю из сети
import Foundation

protocol GeneralViewModelProtocol {
    var movies: [MovieResponse] { get set }
    var showError: ((String) -> Void)? { get set }
    func loadData(count: Int)
    var reloadData: (() -> Void)? { get set }
    var reloadImageData: (() -> Void)? { get set }
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var reloadImageData: (() -> Void)?
    var movies: [MovieResponse] = [] {
        didSet{
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
            movies.append(movie)
                getImage()
            
        case .failure(let error):
            DispatchQueue.main.async { [ weak self ] in
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
//    private func convertToMovieResponse(_ response: MovieResponse) {
//        let movieResponseViewModel = MovieResponseViewModel(response)
//        movies.append(movieResponseViewModel)
//    }
    var imageData: Data?
    private func getImage() {
        for (i, film) in movies.enumerated() {
            if let url = film.poster?.url {
                ApiManager.getImage(url: url) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            let movie = self?.movies[i] as? MovieResponse
                            self?.imageData = data
                            self?.reloadImageData?()
                        case .failure(let error):
                            self?.showError?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}
