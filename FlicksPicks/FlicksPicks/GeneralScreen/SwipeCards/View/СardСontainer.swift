//
//  СardСontainer.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import UIKit

final class СardСontainer: UIView, SwipeCardsDelegate {
    // MARK: - Properties
    private var cardsToShow: Int = 0
    private var cardsToBeVisible: Int = 3
    private var cardViews : [SwipeCardView] = []
    private var remainingCards: Int = 0
    
    private let horizontalInset: CGFloat = 10.0
    private let verticalInset: CGFloat = 10.0
    
    private var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    
     var viewModel: GeneralViewModelProtocol
    
    //MARK: - Initialization
    override init(frame: CGRect) {
       
        self.viewModel = GeneralViewModel()
        super.init(frame: .zero)
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
            if let self {
                self.addCardView(cardView: self.card(at: 0), atIndex: 0)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    func numberOfCardsToShow() -> Int {
        return viewModel.movies.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModel.movies[index]
        return card
    }
    
    private func reloadData() {
        removeAllCardViews()
        setNeedsLayout()
        layoutIfNeeded()
        remainingCards = cardsToShow
        
        for i in 0..<min(cardsToShow,cardsToBeVisible) {
            addCardView(cardView: card(at: i), atIndex: i )
        }
    }
    
    private func addCardView(cardView: SwipeCardView, atIndex index: Int) {
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingCards -= 1
    }
    
    func addCardFrame(index: Int, cardView: SwipeCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
        
        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset
        
        cardView.frame = cardViewFrame
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    // MARK: - Methods
    func swipeDidEnd(on view: SwipeCardView) {
        view.removeFromSuperview()
        
        if remainingCards > 0 {
            let newIndex = numberOfCardsToShow() - remainingCards
            addCardView(cardView: card(at: newIndex), atIndex: 2)
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
            }
        }else {
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
            }
        }
        
    }
}
