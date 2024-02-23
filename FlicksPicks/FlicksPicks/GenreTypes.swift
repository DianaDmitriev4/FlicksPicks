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
    case detective
    
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
        case .detective:
            "&genres.name=детектив"
        }
    }
    
    var genreName: String {
        switch self {
        case .comedy:
            "Comedy".localized
        case .drama:
            "Drama".localized
        case .actionMovie:
            "Action movie".localized
        case .horror:
            "Horror".localized
        case .adventures:
            "Adventures".localized
        case .thriller:
            "Thriller".localized
        case .fantastic:
            "Fantastic".localized
        case .detective:
            "Detective".localized
        }
    }
}
