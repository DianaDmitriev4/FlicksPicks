//
//  SwipeCardsDataSource.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import Foundation

protocol SwipeCardsDelegate: AnyObject {
    func swipeDidEnd(on view: SwipeCardView, needSave: Bool)
}
