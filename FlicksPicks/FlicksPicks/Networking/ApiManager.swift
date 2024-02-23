//
//  ApiManager.swift
//  FlicksPicks
//
//  Created by User on 06.01.2024.
//

import Foundation

final class ApiManager {
        private static let token = "3CSCFW6-77B43AX-QRMSPM0-TWH6EV2" 
//    private static let token = "F7HTR22-3T3MQ15-JBBR889-EWM0898"
    
    static func getFilms(genre: [GenreTypes]?, page: Int, completion: @escaping (Result<[Doc], Error>) -> Void) {
        var selectedGenres: String = ""
        if let genre {
            selectedGenres = genre.compactMap { $0.stringForUrl }.joined()
        }
        let headers = [
            "accept": "application/json",
            "X-API-KEY": token
        ]
        guard let url = URL(string: "https://api.kinopoisk.dev/v1.4/movie?page=\(page)&limit=20&type=movie&rating.kp=6-10\(selectedGenres)") else { return }
        print("URL: \(url)")
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
        
    private static func handleResponse(data: Data?, error: Error?, completion: @escaping (Result<[Doc], Error>) -> ()) {
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
