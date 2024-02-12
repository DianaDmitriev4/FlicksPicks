//
//  MovieResponseViewModel.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//


import Foundation

protocol MovieResponseViewModelProtocol {
    var poster: String { get }
    var rating: Double { get }
    var name: String { get }
    var description: String { get }
    var imageData: Data? { get set }
    var year: Int { get }
}

final class MovieResponseViewModel: MovieResponseViewModelProtocol {
    let poster: String
    let rating: Double
    let name: String
    let description: String
    //    let genres: [String]
    //    let countries: [String]
    var imageData: Data?
    let year: Int
    
    init(_ from: Doc) {
        self.poster = from.poster?.url ?? ""
        self.rating = from.rating?.kp ?? 0.0
        self.name = from.name ?? ""
        self.description = from.description ?? ""
        self.year = from.year ?? 0
        //        self.countries = from.countries?.compactMap { $0.name } ?? []
        //        self.genres = from.genres?.compactMap { $0.name } ?? []
    }
}
