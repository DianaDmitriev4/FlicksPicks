//
//  FiltersViewModel.swift
//  FlicksPicks
//
//  Created by User on 15.01.2024.
//

import Foundation

protocol FiltersViewModelProtocol {
    var genresType: [String] { get }
    var selectedGenres: [GenreTypes] { get set }
    var disappearClosure: (([GenreTypes]) -> Void)? { get set }
}

final class FiltersViewModel: FiltersViewModelProtocol {
    private(set) var genresType: [String] = []
    var selectedGenres: [GenreTypes] = [] 
    var disappearClosure: (([GenreTypes]) -> Void)?
    
    //MARK: - Initialization
    init() {
        fillArrayWithGenresName()
    }
    
    // MARK: - Private methods
    private func fillArrayWithGenresName() {
        let data = FiltersModel()
        genresType = data.genresName
    }
}
