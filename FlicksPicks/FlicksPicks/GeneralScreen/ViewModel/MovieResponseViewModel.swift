//
//  MovieResponseViewModel.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//


import Foundation

final class MovieResponseViewModel {
    let poster: String
    let rating: Double
    let name: String
    let description: String
//    let genres: [GenresType]
//    let countries: [CountriesType]
    var imageData: Data?
    
    init(_ from: MovieResponse) {
        self.poster = from.poster?.url ?? ""
        self.rating = from.rating?.kp ?? 0.0
        self.name = from.name ?? ""
        self.description = from.description ?? ""
        
        
//        self.poster = PosterType(from.poster)
//        self.rating = RatingType(from.rating)
//        self.name = from.name ?? ""
//        self.description = from.description ?? ""
//        self.genres = from.genres.map { GenresType ($0) }
//        self.countries = from.countries.map { CountriesType ($0) }
    }
}

final class PosterType {
var url: String
    
    init(_ from: Poster?) {
        self.url = from?.url ?? ""
    }
}

final class RatingType {
    var kp: Double
    
    init(_ from: Rating?) {
        self.kp = from?.kp ?? 0.0
    }
}

//final class GenresType {
//let name: String
//    
//    init(_ from: Genres?) {
//        self.name = from?.name ?? ""
//    }
//}
//
//final class CountriesType {
//    let name: String
//    
//    init(_ from: Countries?) {
//        self.name = from?.name ?? ""
//    }
//}
