//
//  GenerTypes.swift
//  FlicksPicks
//
//  Created by User on 15.01.2024.
//

import Foundation

enum GenreTypes: String {
    case comedy
    case drama
    case actionMovie
    case horror
    case adventures
    case thriller
    case fantastic
    case documentary
    
    var  stringForUrl: String {
        switch self {
        case .comedy:
            "&genres.name=комедия"
        case .drama:
            "&genres.name=драма"
        case .actionMovie:
            "&genres.name=боевик"
        case .horror:
            "&genres.name=ужасы"
        case .adventures:
            "&genres.name=приключения"
        case .thriller:
            "&genres.name=триллер"
        case .fantastic:
            "&genres.name=фантастика"
        case .documentary:
            "&genres.name=документальный"
        }
    }
    
    var genreName: String {
        switch self {
        case .comedy:
            "Comedy"
        case .drama:
            "Drama"
        case .actionMovie:
            "Action movie"
        case .horror:
            "Horror"
        case .adventures:
            "Adventures"
        case .thriller:
            "Thriller"
        case .fantastic:
            "Fantastic"
        case .documentary:
            "Documentary"
        }
    }
}
