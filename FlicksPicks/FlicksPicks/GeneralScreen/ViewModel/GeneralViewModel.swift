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
    var startLoading: (() -> Void)? { get set }
    var endLoading: (() -> Void)? { get set }
    var getMoreMovies: (() -> Void)? { get set }
    var page: Int { get set }
    func loadData(genre: [GenreTypes]?)
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var page = 0
    var reloadData: (() -> Void)?
    var startLoading: (() -> Void)?
    var endLoading: (() -> Void)?
    var showError: ((String) -> Void)?
    var getMoreMovies: (() -> Void)?
    var movies: [MovieResponseViewModel] = [] {
        didSet {
            movies.forEach { print($0.name) }
        }
    }
    var currentIndex = 0 {
        didSet {
            let range = currentIndex / 10
            if currentIndex == 3 + (10 * range) {
//            if currentIndex == 3 {
                getMoreMovies?()
            }
        }
    }
    
    // MARK: - Methods
    func loadData(genre: [GenreTypes]?) {
        // TODO: поправить поиск по другим жанрам
        if page == 0 {
        DispatchQueue.main.async { [weak self] in
                self?.startLoading?()
            }
        }
        page += 1
        ApiManager.getFilms(genre: genre, page: page) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    // MARK: - Private methods
    private func handleResult(result: (Result<[Doc], Error>)) {
        DispatchQueue.main.async { [ weak self ] in
            switch result {
            case .success(let movie):
                self?.convertToMovieResponse(movie)
                
            case .failure(let error):
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    private func convertToMovieResponse(_ response: [Doc]) {
        let movieResponseViewModel = response.map { MovieResponseViewModel($0, imageData: nil) }
        if movies.isEmpty {
            movies = movieResponseViewModel
        } else {
            movies += movieResponseViewModel
        }
        
        getImages { [weak self] in
            DispatchQueue.main.async { [ weak self ] in
                if let self {
                    self.endLoading?()
                    self.reloadData?()
                }
            }
        }
    }
    
    private func getImages(completion: @escaping () -> Void) {
        let moviesCount = movies.count
        let loadDidFinish: ([Data]) -> Void = { data in
            if data.count == moviesCount {
                completion()
            }
        }
        var dataArray: [Data] = []
        for (i, film) in movies.enumerated() {
            let url = film.poster
            ApiManager.getImage(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let movie = self?.movies[i]
                    movie?.imageData = data
                    dataArray.append(data)
                case .failure(let error):
                    self?.showError?(error.localizedDescription)
                    print(error.localizedDescription)
                }
                loadDidFinish(dataArray)
            }
        }
    }
}
