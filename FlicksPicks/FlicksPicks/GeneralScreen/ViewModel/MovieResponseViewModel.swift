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
