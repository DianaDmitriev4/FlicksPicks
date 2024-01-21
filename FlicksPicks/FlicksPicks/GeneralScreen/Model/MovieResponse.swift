//
//  Docs.swift
//  FlicksPicks
//
//  Created by User on 01.01.2024.
//


import Foundation

struct MovieResponse: Codable {
    let docs: [Docs]
    let total, limit, page, pages: Int?
}

enum CodingKeys: CodingKey {
    case docs
    case total
    case limit
    case page
    case pages
}
