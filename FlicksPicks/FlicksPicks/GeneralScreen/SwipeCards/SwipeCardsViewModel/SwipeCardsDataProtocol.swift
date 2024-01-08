//
//  SwipeCardsDataProtocol.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import UIKit

protocol SwipeCardsDataProtocol {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}

