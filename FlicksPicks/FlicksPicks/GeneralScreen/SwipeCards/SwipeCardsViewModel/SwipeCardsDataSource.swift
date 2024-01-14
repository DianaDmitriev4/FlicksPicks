//
//  SwipeCardsDataSource.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import Foundation

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}

