//
//  NetworkingError.swift
//  FlicksPicks
//
//  Created by User on 07.01.2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
