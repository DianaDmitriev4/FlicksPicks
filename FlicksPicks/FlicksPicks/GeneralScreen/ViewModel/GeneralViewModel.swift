//
//  GeneralViewModel.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

// TODO: поставить foundation после того, как засетаю из сети
import UIKit

protocol GeneralViewModelProtocol {
    var movies: [MovieResponseViewModel] { get set }
}

final class GeneralViewModel: GeneralViewModelProtocol {
    // MARK: - Properties
    var movies: [MovieResponseViewModel] = []
    
    init() {
        loadMockImage()
    }
    
    // MARK: - Private methods
   private func loadMockImage() {
        movies = [
            MovieResponseViewModel(response: MovieResponse(image: UIImage(named: "mock1") ?? .add, title: "Avatar")),
            MovieResponseViewModel(response: MovieResponse(image: UIImage(named: "mock2") ?? .add, title: "Телекинез")),
            MovieResponseViewModel(response: MovieResponse(image: UIImage(named: "mock3") ?? .add, title: "Остров проклятых")),
            MovieResponseViewModel(response: MovieResponse(image: UIImage(named: "mock4") ?? .add, title: "Время"))
            ]
    }
}
