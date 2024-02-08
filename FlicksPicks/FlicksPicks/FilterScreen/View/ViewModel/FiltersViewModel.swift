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
}

final class FiltersViewModel: FiltersViewModelProtocol {
    private(set) var genresType: [String] = []
    var selectedGenres: [GenreTypes] = [] 
    
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
