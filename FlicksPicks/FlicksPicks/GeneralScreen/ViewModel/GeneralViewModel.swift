//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

// TODO: поставить foundation после того, как засетаю из сети
import Foundation

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get set }
    var showError: ((String) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
    func loadData()
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var movies: [MovieResponseViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)? 
    
    func loadData() {
        ApiManager.getFilms { [weak self] result in
            self?.handleResult(result: result)
            self?.getImage()
        }
    }
    
    private func handleResult(result: (Result<MovieResponse, Error>)) {
        switch result {
        case .success(let movie):
            convertToMovieResponse(movie)
        case .failure(let error):
            DispatchQueue.main.async { [ weak self ] in
                self?.showError?(error.localizedDescription)
            }
        }
    }
    
    private func convertToMovieResponse(_ response: MovieResponse) {
        let movieResponseViewModel = MovieResponseViewModel(response)
        movies.append(movieResponseViewModel)
    }
    
    private func getImage() {
        for movie in movies {
            let url = movie.poster
            
            ApiManager.getImage(url: url) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                            movie.imageData = data
                            let json = try? JSONSerialization.jsonObject(with: data , options: [])
                            print(json ?? "")
                        
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: - Private methods
}
