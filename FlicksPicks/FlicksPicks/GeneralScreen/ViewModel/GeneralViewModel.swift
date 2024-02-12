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
    var selectedMovies: [MovieResponseViewModel] { get set}
    var reloadTable: (() -> Void)? { get set }
    
    func loadData(genre: [GenreTypes]?)
    func save(name: String, year: Int, rating: Double, description: String, urlFromImage: String, imageData: Data)
    func deleteAll()
    func getMovies()
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
            DispatchQueue.main.async { [weak self] in
                self?.reloadTable?()
            }
        }
    }
    var currentIndex = 0
//    let movie: MovieResponseViewModel?
//    
//    init(movie: MovieResponseViewModel?) {
//        self.movie = movie
//        getMovies()
//    }
    
    // MARK: - Methods
    func loadData(genre: [GenreTypes]?) {
        ApiManager.getFilms(genre: genre) { [weak self] result in
            self?.handleResult(result: result)
        }
    }
    
    func save(name: String, year: Int, rating: Double, description: String, urlFromImage: String, imageData: Data) {
        let movie = MovieResponseViewModel(Doc(poster: Poster(url: urlFromImage),
                                               rating: Rating(kp: rating),
                                               name: name,
                                               description: description,
                                               year: year))
//        let movie = ModelFromCoreData(poster: urlFromImage,
//                                      rating: rating,
//                                      name: name,
//                                      description: description,
//                                      imageData: imageData,
//                                      year: year)
        MoviePersistent.save(movie)
    }
    
    func deleteAll() {
//        if let movie {
            MoviePersistent.deleteAll()
//        }
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
    
     func getMovies() {
        let movies = MoviePersistent.fetchAll()
        selectedMovies = []
        selectedMovies = movies
    }
}
