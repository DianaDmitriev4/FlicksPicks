//
//  СardСontainer.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import UIKit

final class СardСontainer: UIView, SwipeCardsDelegate {
    // MARK: - Properties
    private let horizontalInset: CGFloat = 10.0
    private let verticalInset: CGFloat = 10.0
    private var cardsToShow: Int = 0
    private var cardsToBeVisible: Int = 3
    private var remainingCards: Int = 0 {
        didSet {
            print("remain: \(remainingCards)")
        }
    }
    private var viewModel: GeneralViewModelProtocol
    private var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var cardViews: [SwipeCardView] = []
    
    //MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        self.viewModel.reloadData = { [weak self] in
            if let self {
                if self.viewModel.movies.count <= 10 {
                    self.reloadData()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func numberOfCardsToShow() -> Int {
        return viewModel.movies.count
    }
    
    private func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModel.movies[index]
        return card
    }
    
    private func addCardView(cardView: SwipeCardView, atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    private func addCardFrame(index: Int, cardView: SwipeCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
    
    // MARK: - Methods
    func reloadData() {
        setNeedsLayout()
        layoutIfNeeded()
        cardsToShow = numberOfCardsToShow()
        remainingCards = cardsToShow
        
        for i in 0..<min(cardsToShow, cardsToBeVisible) {
            addCardView(cardView: card(at: i), atIndex: i)
        }
    }
    
    func swipeDidEnd(on view: SwipeCardView, needSave: Bool) {
        if needSave {
            MoviePersistent.save(viewModel.movies[viewModel.currentIndex])
        }
        
        viewModel.currentIndex += 1
        let index = viewModel.currentIndex + 2
        print(index)
        view.removeFromSuperview()
        
        if remainingCards > 0 {
            let intervalNumber = (index / 10)
            if index == 9 + (10 * intervalNumber) && intervalNumber + 1 != viewModel.page {
                remainingCards = 11
            }
            addCardView(cardView: card(at: index), atIndex: 2)
            
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    cardView.center = self?.center ?? .zero
                    self?.addCardFrame(index: cardIndex, cardView: cardView)
                    self?.layoutIfNeeded()
                })
            }
        } else {
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    cardView.center = self?.center ?? .zero
                    self?.addCardFrame(index: cardIndex, cardView: cardView)
                    self?.layoutIfNeeded()
                    self?.isUserInteractionEnabled = false
                })
            }
        }
    }
}
