//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import UIKit

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
    var currentIndex: Int { get set }
    
    func loadData(genre: [GenreTypes]?)
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var reloadData: (() -> Void)?
    var showError: ((String) -> Void)?
    var movies: [MovieResponseViewModel] = []
    var currentIndex = 0
    
    // MARK: - Methods
    func loadData(genre: [GenreTypes]?) {
        // TODO: - Start loader
        ApiManager.getFilms(genre: genre) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    // MARK: - Private methods
    private func handleResult(result: (Result<[Doc], Error>)) {
        switch result {
        case .success(let movie):
            convertToMovieResponse(movie)
            
        case .failure(let error):
            DispatchQueue.main.async { [ weak self ] in
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    private func convertToMovieResponse(_ response: [Doc]) {
        let movieResponseViewModel = response.map { MovieResponseViewModel($0, imageData: nil) }
        movies = movieResponseViewModel
        getImages { [weak self] in
            DispatchQueue.main.async { [ weak self ] in
                // TODO: - Stop loader
                self?.reloadData?()
            }
        }
    }
    
    private func getImages(completion: @escaping () -> Void) {
        let moviesCount = movies.count
        let loadDidFinish: (Int) -> Void = { index in
            if index == moviesCount - 1 {
                completion()
            }
        }
        
        for (i, film) in movies.enumerated() {
            let url = film.poster
            ApiManager.getImage(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let movie = self?.movies[i]
                    movie?.imageData = data
                    
                case .failure(let error):
                    self?.showError?(error.localizedDescription)
                }
                loadDidFinish(i)
            }
        }
    }
}
