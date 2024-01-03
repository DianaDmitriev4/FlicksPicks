//
//  MovieResponseViewModel.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

// TODO: поставить foundation после того, как засетаю из сети
import UIKit

final class MovieResponseViewModel {
    let image: UIImage
    let title: String
    
    init(response: MovieResponse) {
        self.image = response.image
        self.title = response.title
    }
}
