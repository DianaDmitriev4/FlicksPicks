//
//  SwipeCardView.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import SnapKit
import UIKit

final class SwipeCardView : UIView {
    //MARK: - Properties
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var viewModel: GeneralViewModelProtocol
    
    var delegate: SwipeCardsDelegate?
    var dataSource: MovieResponseViewModel? {
        didSet {
            print("GET CHANGE FROM ARRAY")
            //                print("Получаем картинку")
            guard let data = self.dataSource?.imageData else { return }
            self.imageView.image = UIImage(data: data)
        }
    }
    
    //MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        print("ПОСТЕРЫ ИНИЦИАЛИЗИРОВАНЫ")
        addSubview(imageView)
        setupConstraints()
        addPanGestureOnCards()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let card = sender.view as! SwipeCardView
        let newPoint = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + newPoint.x, y: centerOfParentContainer.y + newPoint.y)
        
        switch sender.state {
        case .ended:
            // Swipe right
            if (card.center.x) > 400 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) { [ weak self ] in
                    if let self {
                        card.center = CGPoint(x: centerOfParentContainer.x + newPoint.x + 200, y: centerOfParentContainer.y + newPoint.y + 75)
                        card.alpha = 0
                        self.layoutIfNeeded()
                        let currentMovie = self.viewModel.movies[self.viewModel.currentIndex]
                        //                    self.viewModel.selectedMovies.append(self.viewModel.movies[self.viewModel.currentIndex])
//                        self.viewModel.selectedMovies.append(currentMovie)
                        //                    let vc = SelectedMovies(viewModel: GeneralViewModel(movie: currentMovie))
                        self.viewModel.save(currentMovie)
                    }
                }
                return
                // Swipe left
            } else if card.center.x < -10 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) { [weak self] in
                    card.center = CGPoint(x: centerOfParentContainer.x + newPoint.x - 200, y: centerOfParentContainer.y + newPoint.y + 75)
                    card.alpha = 0
                    self?.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) { [weak self] in
                card.transform = .identity
                if let self {
                    card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                    self.layoutIfNeeded()
                }
            }
        case .changed:
            let rotation = tan(newPoint.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
        default:
            break
        }
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
}
