//
//  ApiManager.swift
//  FlicksPicks
//
//  Created by User on 06.01.2024.
//

import Foundation

enum GenresSearch: String {
    case comedy = "&genres.name=%D0%BA%D0%BE%D0%BC%D0%B5%D0%B4%D0%B8%D1%8F"
    case drama = "&genres.name=%D0%B4%D1%80%D0%B0%D0%BC%D0%B0"
    case actionMovie = "&genres.name=%D0%B1%D0%BE%D0%B5%D0%B2%D0%B8%D0%BA"
    case horror = "&genres.name=%D1%83%D0%B6%D0%B0%D1%81%D1%8B"
    case adventures = "&genres.name=%D0%BF%D1%80%D0%B8%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D1%8F"
    case thriller = "&genres.name=%D1%82%D1%80%D0%B8%D0%BB%D0%BB%D0%B5%D1%80"
    case fantastic = "&genres.name=%D1%84%D0%B0%D0%BD%D1%82%D0%B0%D1%81%D1%82%D0%B8%D0%BA%D0%B0"
}

final class ApiManager {
    //    private static let token = "3CSCFW6-77B43AX-QRMSPM0-TWH6EV2" - МОЙ
    private static let token = "F7HTR22-3T3MQ15-JBBR889-EWM0898"
    
    static func getFilms(genre: [GenresSearch], count: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let headers = [
            "accept": "application/json",
            "X-API-KEY": token
        ]
        for _ in 1...count {
            let selectedGenres = genre.reduce("") { $0 + $1.rawValue }
            guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie/random?isSeries=false&rating.kp=7-10\(selectedGenres)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared.dataTask(with: request) { data, _, error in
                handleResponse(data: data,
                               error: error,
                               completion: completion)
            }
            session.resume()
        }
    }
    
    static func getImage(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data {
                completion(.success(data))
            } else if let error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
    private static func handleResponse(data: Data?, error: Error?, completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            do {
                let films = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(films))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
