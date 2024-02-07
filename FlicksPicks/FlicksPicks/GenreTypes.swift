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
            "&genres.name=%D0%BA%D0%BE%D0%BC%D0%B5%D0%B4%D0%B8%D1%8F"
        case .drama:
            "&genres.name=%D0%B4%D1%80%D0%B0%D0%BC%D0%B0"
        case .actionMovie:
            "&genres.name=%D0%B1%D0%BE%D0%B5%D0%B2%D0%B8%D0%BA"
        case .horror:
            "&genres.name=%D1%83%D0%B6%D0%B0%D1%81%D1%8B"
        case .adventures:
            "&genres.name=%D0%BF%D1%80%D0%B8%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D1%8F"
        case .thriller:
            "&genres.name=%D1%82%D1%80%D0%B8%D0%BB%D0%BB%D0%B5%D1%80"
        case .fantastic:
            "&genres.name=%D1%84%D0%B0%D0%BD%D1%82%D0%B0%D1%81%D1%82%D0%B8%D0%BA%D0%B0"
        case .documentary:
            "&genres.name=%D0%B4%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9"
        }
    }
//
//    case comedy = "&genres.name=%D0%BA%D0%BE%D0%BC%D0%B5%D0%B4%D0%B8%D1%8F"
//    case drama = "&genres.name=%D0%B4%D1%80%D0%B0%D0%BC%D0%B0"
//    case actionMovie = "&genres.name=%D0%B1%D0%BE%D0%B5%D0%B2%D0%B8%D0%BA"
//    case horror = "&genres.name=%D1%83%D0%B6%D0%B0%D1%81%D1%8B"
//    case adventures = "&genres.name=%D0%BF%D1%80%D0%B8%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D1%8F"
//    case thriller = "&genres.name=%D1%82%D1%80%D0%B8%D0%BB%D0%BB%D0%B5%D1%80"
//    case fantastic = "&genres.name=%D1%84%D0%B0%D0%BD%D1%82%D0%B0%D1%81%D1%82%D0%B8%D0%BA%D0%B0"
//    case documentary = "&genres.name=%D0%B4%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9"
//    
//    var  stringInUrl: String {
//        return self.rawValue
//    }
    var genreName: String {
        switch self {
        case .comedy:
            "comedy"
        case .drama:
            "drama"
        case .actionMovie:
            "action movie"
        case .horror:
            "horror"
        case .adventures:
            "adventures"
        case .thriller:
            "thriller"
        case .fantastic:
            "fantastic"
        case .documentary:
            "documentary"
        }
    }
}
