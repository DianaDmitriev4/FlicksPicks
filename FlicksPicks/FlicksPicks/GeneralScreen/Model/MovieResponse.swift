//
//  MovieResponse.swift
//  FlicksPicks
//
//  Created by User on 01.01.2024.
//


import Foundation

struct MovieResponse: Codable {
    let poster: Poster?
    let rating: Rating?
    let name: String?
    let description: String?
//    let genres: [Genres]?
//    let countries: [Country]?
    let year: Int?
    
    enum CodingKeys: CodingKey {
        case poster
        case rating
        case name
        case description
//        case genres
//        case countries
        case year
    }
}

struct Poster: Codable {
    let url: String
    
    enum CodingKeys: CodingKey {
        case url
    }
}

struct Rating: Codable {
    let kp: Double
    
    enum CodingKeys: CodingKey {
        case kp
    }
}

struct Genres: Codable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
}

struct Country: Codable {
    let name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
}
