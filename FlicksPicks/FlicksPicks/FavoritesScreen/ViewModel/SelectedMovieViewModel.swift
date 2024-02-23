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
    
    func deleteAll()
    func deleteMovie(_ movie: MovieResponseViewModel)
    func getMovies()
}

final class SelectedMovieViewModel: SelectedMovieViewModelProtocol {
    var reloadTable: (() -> Void)?
    var selectedMovies: [MovieResponseViewModel] = []  {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadTable?()
            }
        }
    }
    
    func getMovies() {
        selectedMovies = MoviePersistent.fetchAll()
    }
    
    func deleteAll() {
        MoviePersistent.deleteAll()
    }
    
    func deleteMovie(_ movie: MovieResponseViewModel) {
        MoviePersistent.deleteEntity(movie)
    }
}
