//
//  ApiManager.swift
//  FlicksPicks
//
//  Created by User on 06.01.2024.
//

import Foundation

final class ApiManager {
    //    private static let token = "3CSCFW6-77B43AX-QRMSPM0-TWH6EV2" - МОЙ
    private static let token = "F7HTR22-3T3MQ15-JBBR889-EWM0898"
    
//    static func getFilms(genre: [GenreTypes]?, count: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
    static func getFilms(count: Int, completion: @escaping (Result<[Docs], Error>) -> Void) {
        let headers = [
            "accept": "application/json",
            "X-API-KEY": token
        ]
//            let selectedGenres = genre?.reduce("") { $0 + $1.rawValue }
//            guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie/random?isSeries=false&rating.kp=7-10\(selectedGenres ?? "")") else { return }
            guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie?type=movie&rating.kp=7-10") else { return }
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
    
    private static func handleResponse(data: Data?, error: Error?, completion: @escaping (Result<[Docs], Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            do {
                let films = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(films.docs))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
