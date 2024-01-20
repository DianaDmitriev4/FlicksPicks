//
//  СardСontainer.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import UIKit

final class СardСontainer: UIView, SwipeCardsDelegate {
    // MARK: - Properties
    private var numberOfCardsToShow: Int = 0
    private var cardsToBeVisible: Int = 3
    private var cardViews : [SwipeCardView] = []
    private var remainingCards: Int = 0
    
    private let horizontalInset: CGFloat = 10.0
    private let verticalInset: CGFloat = 10.0
    private var viewModel: GeneralViewModelProtocol
    private var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
            print("СРАБОТАЛ ДИДСЕТ У КАРТОЧЕК")
        }
    }
    
    var currentIndex = 0
    
    //MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        viewModel = GeneralViewModel()
    init(viewModel: GeneralViewModelProtocol) {
        
        self.viewModel = viewModel
        print("КАРТОЧКИ ИНИЦИАЛИЗИРОВАНЫ")
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func reloadData() {
        removeAllCardViews()
        guard let data = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = data.numberOfCardsToShow()
        remainingCards = numberOfCardsToShow
        
        for i in 0..<min(numberOfCardsToShow,cardsToBeVisible) {
            addCardView(cardView: data.card(at: i), atIndex: i )
        }
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
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    // MARK: - Methods
    func swipeDidEnd(on view: SwipeCardView) {
        view.removeFromSuperview()
        guard let data = dataSource else { return }
        if remainingCards > 0 {
            let newIndex = data.numberOfCardsToShow() - remainingCards
            addCardView(cardView: data.card(at: newIndex), atIndex: 2)
            for (cardIndex, cardView) in visibleCards.enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                    self.viewModel.currentIndex = cardIndex
                })
            }
        } else {
            for (cardIndex, cardView) in visibleCards.enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
            }
        }
    }
}
