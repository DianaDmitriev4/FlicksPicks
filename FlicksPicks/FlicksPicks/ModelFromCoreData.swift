//
//  ModelFromCoreData.swift
//  FlicksPicks
//
//  Created by User on 12.02.2024.
//

import Foundation

struct ModelFromCoreData: MovieResponseViewModelProtocol {
    let poster: String
    let rating: Double
    let name: String
    let description: String
    var imageData: Data?
    let year: Int
}
