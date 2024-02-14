//
//  SelectedMovieViewModel.swift
//  FlicksPicks
//
//  Created by User on 12.02.2024.
//

import Foundation

protocol SelectedMovieViewModelProtocol {
    var selectedMovies: [MovieResponseViewModel] { get set}
    var reloadTable: (() -> Void)? { get set }
    
    func save(_ from: MovieResponseViewModel)
    func deleteAll()
    func deleteMovie(_ movie: MovieResponseViewModel)
    func getMovies()
}

final class SelectedMovieViewModel: SelectedMovieViewModelProtocol {
    var reloadTable: (() -> Void)?
    var selectedMovies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadTable?()
            }
        }
    }
    
    init() {
        getMovies()
    }

    func getMovies() {
        let movies = MoviePersistent.fetchAll()
        selectedMovies = []
        selectedMovies = movies
    }
    
    func save(_ from: MovieResponseViewModel) {
        let movie = MovieResponseViewModel(Doc(poster: Poster(url: from.poster),
                                               rating: Rating(kp: from.rating),
                                               name: from.name,
                                               description: from.description,
                                               genres: nil, 
                                               countries: nil,
                                               year: from.year),
                                           imageData: from.imageData)
        MoviePersistent.save(movie)
    }
    
    func deleteAll() {
        MoviePersistent.deleteAll()
    }
    
    func deleteMovie(_ movie: MovieResponseViewModel) {
        MoviePersistent.deleteEntity(movie)
    }
}
