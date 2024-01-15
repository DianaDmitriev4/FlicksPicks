//
//  FiltersViewModel.swift
//  FlicksPicks
//
//  Created by User on 15.01.2024.
//

import Foundation

protocol FiltersViewModelProtocol {
    var selectedGenres: [GenreTypes] { get set }
}

final class FiltersViewModel: FiltersViewModelProtocol {
    var selectedGenres: [GenreTypes] = []
}
